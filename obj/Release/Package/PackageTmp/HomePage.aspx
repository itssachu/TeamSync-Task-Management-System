<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="TeamSync.HomePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TeamSync - Smart Team Management & Collaboration Platform</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet" />
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet" />

    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body { background: #f8fafc; overflow-x: hidden; color: #334155; }
        html { scroll-behavior: smooth; }

        /* Typography Utilities */
        .text-gradient {
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Navbar Styling */
        .navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(15px);
            box-shadow: 0 4px 30px rgba(0,0,0,0.03);
            padding: 20px 0;
            transition: all 0.3s ease;
        }
        .navbar-brand { font-size: 28px; font-weight: 800; color: #2563eb !important; }
        .navbar-brand span { color: #0f172a; }
        .nav-link { font-weight: 500; margin-left: 20px; color: #475569 !important; transition: 0.3s; }
        .nav-link:hover, .nav-link.active { color: #2563eb !important; }

        /* Hero Section */
        .hero {
            min-height: 100vh;
            background: radial-gradient(circle at 90% 10%, rgba(124, 58, 237, 0.08) 0%, transparent 40%),
                        radial-gradient(circle at 10% 90%, rgba(37, 99, 235, 0.06) 0%, transparent 40%),
                        #fff;
            display: flex; align-items: center; padding-top: 120px; position: relative;
        }
        .hero-content h1 { font-size: 60px; font-weight: 800; line-height: 1.15; color: #0f172a; margin-bottom: 25px; }
        .hero-content p { color: #64748b; font-size: 19px; line-height: 1.8; margin-bottom: 35px; }

        /* Custom Button Framework */
        .btn-custom {
            padding: 14px 32px; border-radius: 50px; font-size: 16px; font-weight: 600; transition: 0.4s; display: inline-flex; align-items: center; gap: 8px;
        }
        .btn-primary-custom { background: linear-gradient(135deg, #2563eb, #7c3aed); color: white; border: none; box-shadow: 0 10px 20px rgba(37, 99, 235, 0.2); }
        .btn-primary-custom:hover { transform: translateY(-3px); box-shadow: 0 15px 25px rgba(37, 99, 235, 0.3); color: white; }
        .btn-outline-custom { background: transparent; border: 2px solid #cbd5e1; color: #475569; margin-left: 15px; }
        .btn-outline-custom:hover { border-color: #2563eb; color: #2563eb; transform: translateY(-3px); }

        /* Floating Hero Animation */
        .hero-image-wrapper { position: relative; }
        .hero-image { animation: float 6s ease-in-out infinite; filter: drop-shadow(0 30px 50px rgba(0,0,0,0.1)); }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
        }

        /* Section Global Layouts */
        section { padding: 100px 0; }
        .section-title { text-align: center; margin-bottom: 70px; }
        .section-title span { text-transform: uppercase; font-size: 14px; font-weight: 700; letter-spacing: 2px; color: #2563eb; display: block; margin-bottom: 10px; }
        .section-title h2 { font-size: 40px; font-weight: 800; color: #0f172a; margin-bottom: 20px; }
        .section-title p { color: #64748b; font-size: 18px; max-width: 650px; margin: auto; }

        /* Feature Cards Layer */
        .feature-card {
            background: white; border-radius: 24px; padding: 40px; height: 100%; transition: 0.4s; border: 1px solid #f1f5f9; box-shadow: 0 10px 30px rgba(15, 23, 42, 0.01);
        }
        .feature-card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(15, 23, 42, 0.06); border-color: rgba(37,99,235,0.1); }
        .feature-icon {
            width: 60px; height: 60px; border-radius: 16px; background: rgba(37, 99, 235, 0.05); display: flex; align-items: center; justify-content: center; color: #2563eb; font-size: 26px; margin-bottom: 25px; transition: 0.3s;
        }
        .feature-card:hover .feature-icon { background: linear-gradient(135deg, #2563eb, #7c3aed); color: white; }
        .feature-card h4 { font-weight: 700; margin-bottom: 15px; color: #0f172a; font-size: 20px; }
        .feature-card p { color: #64748b; line-height: 1.7; font-size: 15px; margin-bottom: 0; }

        /* Workflow Steps Block */
        .step-card { text-align: center; position: relative; }
        .step-number { width: 50px; height: 50px; border-radius: 50%; background: #eff6ff; border: 2px solid #bfdbfe; color: #2563eb; font-weight: 700; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px auto; font-size: 18px; }
        .step-card h5 { font-weight: 700; color: #0f172a; margin-bottom: 10px; }
        .step-card p { color: #64748b; font-size: 14px; }

        /* Stats Infrastructure */
        .stats-section { background: #0f172a; padding: 80px 0; border-radius: 40px; margin: 40px 0; }
        .stat-box h2 { font-size: 52px; font-weight: 800; color: white; margin-bottom: 10px; }
        .stat-box p { font-size: 16px; color: #94a3b8; margin-bottom: 0; }

        /* Testimonials Slider Setup */
        .testimonial-card { background: white; border-radius: 20px; padding: 35px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); border: 1px solid #f1f5f9; height: 100%; }
        .user-meta { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; }
        .user-meta img { width: 55px; height: 55px; border-radius: 50%; object-fit: cover; }
        .user-meta h5 { font-weight: 700; color: #0f172a; margin: 0; font-size: 16px; }
        .user-meta span { color: #64748b; font-size: 13px; }
        .testimonial-card p { color: #475569; font-style: italic; font-size: 15px; line-height: 1.7; }

        /* Pricing Area */
        .pricing-card { background: white; border-radius: 24px; padding: 40px; border: 1px solid #e2e8f0; height: 100%; transition: 0.3s; position: relative; }
        .pricing-card.popular { border: 2px solid #2563eb; transform: scale(1.03); }
        .popular-badge { position: absolute; top: -15px; left: 50%; transform: translateX(-50%); background: #2563eb; color: white; padding: 4px 16px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase; }
        .price h3 { font-size: 46px; font-weight: 800; color: #0f172a; }
        .price span { color: #64748b; font-size: 16px; }

        /* FAQ Styling */
        .accordion-item { border-radius: 16px !important; margin-bottom: 15px; border: 1px solid #e2e8f0; overflow: hidden; }
        .accordion-button { font-weight: 600; color: #0f172a; padding: 20px; }
        .accordion-button:not(.collapsed) { background-color: #f8fafc; color: #2563eb; box-shadow: none; }

        /* Link Infrastructure Grid */
        .useful-link-card {
            background: white; border-radius: 20px; padding: 30px 20px; text-align: center; transition: 0.3s; border: 1px solid #e2e8f0; display: block; text-decoration: none;
        }
        .useful-link-card i { font-size: 32px; color: #2563eb; display: block; margin-bottom: 15px; transition: 0.3s; }
        .useful-link-card span { font-size: 15px; font-weight: 600; color: #334155; transition: 0.3s; }
        .useful-link-card:hover { background: linear-gradient(135deg, #2563eb, #7c3aed); transform: translateY(-5px); box-shadow: 0 10px 25px rgba(37,99,235,0.15); border-color: transparent; }
        .useful-link-card:hover i, .useful-link-card:hover span { color: white; }

        /* Footer System */
        footer { background: #0f172a; color: #94a3b8; padding: 80px 0 30px 0; font-size: 14px; }
        footer h4 { color: white; font-weight: 700; margin-bottom: 25px; }
        footer a { color: #cbd5e1; text-decoration: none; transition: 0.3s; }
        footer a:hover { color: #2563eb; }
        .footer-bottom { border-top: 1px solid #1e293b; padding-top: 30px; margin-top: 50px; text-align: center; }

        @media(max-width:991px) {
            .hero-content h1 { font-size: 42px; }
            .hero { text-align: center; padding-top: 140px; min-height: auto; padding-bottom: 60px; }
            .btn-outline-custom { margin-left: 0; margin-top: 15px; display: flex; justify-content: center; }
            .pricing-card.popular { transform: scale(1); }
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <!-- Navigation Bar Setup -->
        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#home">Team<span>Sync</span></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto align-items-lg-center">
                        <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#what-we-do">What We Do</a></li>
                        <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                        <li class="nav-item"><a class="nav-link" href="#pricing">Pricing</a></li>
                        <li class="nav-item"><a class="nav-link" href="#links">Quick Links</a></li>
                        <li class="nav-item ms-lg-3">
                            <a href="Login.aspx" class="btn btn-primary rounded-pill px-4" style="background:#2563eb; border:none;">Client Login</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Hero Context Area -->
        <section class="hero" id="home">
            <div class="container">
                <div class="row align-items-center g-5">
                    <div class="col-lg-6">
                        <div class="hero-content" data-aos="fade-right">
                            <span class="badge bg-blue mb-3 py-2 px-3 rounded-pill" style="background: rgba(37, 99, 235, 0.1); color: #2563eb; font-weight:600;">Streamline Workspace Operations</span>
                            <h1>The Intelligent Workspace For Modern Teams</h1>
                            <p>
                                Bring clarity, accountability, and real-time synchronization to your entire corporate network. Eliminate communication fragmentation with advanced project engines built to match fast team operational execution speeds.
                            </p>
                            <div class="d-sm-flex align-items-center">
                                <a href="Register.aspx" class="btn btn-custom btn-primary-custom">
                                    Create Free Workspace <i class="bi bi-arrow-right"></i>
                                </a>
                                <a href="#what-we-do" class="btn btn-custom btn-outline-custom">
                                    See How It Works
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 text-center hero-image-wrapper" data-aos="zoom-in" data-aos-delay="200">
                        <img src="https://cdn-icons-png.flaticon.com/512/1055/1055687.png" class="img-fluid hero-image" alt="Workspace Overview Dashboard" style="max-width:85%;" />
                    </div>
                </div>
            </div>
        </section>

        <!-- Dynamic Content Section: What We Do -->
        <section id="what-we-do" class="bg-white">
            <div class="container">
                <div class="section-title" data-aos="fade-up">
                    <span>Core Platform Value</span>
                    <h2>Engineered for Modern Performance Alignment</h2>
                    <p>TeamSync contextualizes data tracking models into unified operational spaces, ensuring cross-functional departments execute projects smoothly without complex bottlenecks.</p>
                </div>

                <div class="row align-items-center g-5">
                    <div class="col-lg-6" data-aos="fade-right">
                        <div class="about-img-box position-relative">
                            <img src="https://cdn-icons-png.flaticon.com/512/4140/4140047.png" class="img-fluid mx-auto d-block" alt="Collaborative Operations Diagram" style="max-width: 80%;" />
                        </div>
                    </div>
                    <div class="col-lg-6" data-aos="fade-left">
                        <h3 class="fw-bold mb-4" style="color:#0f172a;">Consolidate Tasks, Documentation, & Analytics</h3>
                        <p class="mb-4 text-muted leading-relaxed">
                            Many companies rely on disparate messaging tools, complex spreadsheets, and detached tracking portals to monitor everyday project components. TeamSync systematically bridges that structural divide by keeping metrics linked in a single master architecture.
                        </p>
                        
                        <div class="d-flex align-items-start gap-3 mb-3">
                            <div class="p-2 rounded-circle bg-light text-primary"><i class="bi bi-check2-all fs-5"></i></div>
                            <div>
                                <h6 class="fw-bold mb-1">Clear Ownership Tracking</h6>
                                <p class="text-muted small mb-0">Every project development lifecycle stage directly highlights target milestones and individual stakeholder responsibility.</p>
                            </div>
                        </div>

                        <div class="d-flex align-items-start gap-3 mb-3">
                            <div class="p-2 rounded-circle bg-light text-primary"><i class="bi bi-graph-up-arrow fs-5"></i></div>
                            <div>
                                <h6 class="fw-bold mb-1">Live Progression Pipelines</h6>
                                <p class="text-muted small mb-0">Managers track live task execution updates via custom boards, reducing administrative friction and repetitive check-ins.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Workflow Step Sequence -->
                <div class="row mt-5 pt-5 g-4">
                    <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                        <div class="step-card">
                            <div class="step-number">1</div>
                            <h5>Set Up Workspace</h5>
                            <p class="text-muted">Create private portals tailored directly around specific operational sectors or active business clients.</p>
                        </div>
                    </div>
                    <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                        <div class="step-card">
                            <div class="step-number">2</div>
                            <h5>Distribute Requirements</h5>
                            <p class="text-muted">Assign structural cards containing specific assets, file uploads, prioritization markers, and firm due-dates.</p>
                        </div>
                    </div>
                    <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                        <div class="step-card">
                            <div class="step-number">3</div>
                            <h5>Analyze Progression</h5>
                            <p class="text-muted">Generate cross-functional reports detailing team operational speeds and exact milestones met.</p>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <!-- Features Matrix Section -->
        <section id="features">
            <div class="container">
                <div class="section-title" data-aos="fade-up">
                    <span>Robust System Modules</span>
                    <h2>Everything You Need To Build Momentum</h2>
                    <p>Experience standard enterprise tool management features configured cleanly within a unified, intuitive user interface.</p>
                </div>

                <div class="row g-4">
                    <div class="col-lg-4 col-md-6" data-aos="fade-up">
                        <div class="feature-card">
                            <div class="feature-icon"><i class="bi bi-kanban"></i></div>
                            <h4>Task Allocation Engine</h4>
                            <p>Build multi-stage boards containing functional task tags, dependency routes, and chronological performance expectations.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="feature-card">
                            <div class="feature-icon"><i class="bi bi-people-fill"></i></div>
                            <h4>Contextual Team Threads</h4>
                            <p>Discuss project specifications directly inside contextual operational item blocks, keeping file histories organized perfectly.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="feature-card">
                            <div class="feature-icon"><i class="bi bi-bar-chart-fill"></i></div>
                            <h4>Unified Data Analytics</h4>
                            <p>Review standard workflow efficiency variables through structured graphic dashboard layouts populated in real-time.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6" data-aos="fade-up">
                        <div class="feature-card">
                            <div class="feature-icon"><i class="bi bi-calendar-event"></i></div>
                            <h4>Chronological Schedulers</h4>
                            <p>Synchronize milestones seamlessly with structural time matrices to keep upcoming sprint items fully aligned.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="feature-card">
                            <div class="feature-icon"><i class="bi bi-bell-fill"></i></div>
                            <h4>Activity Push Updates</h4>
                            <p>Stay informed with automated notification flags triggering on task status shifts and modification updates.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="feature-card">
                            <div class="feature-icon"><i class="bi bi-shield-lock-fill"></i></div>
                            <h4>Enterprise Guard Protocols</h4>
                            <p>Keep sensitive development frameworks isolated and secure with comprehensive data encryption layers.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Metric Infrastructure Section -->
        <div class="container">
            <section class="stats-section">
                <div class="row text-center g-4">
                    <div class="col-md-3" data-aos="zoom-in">
                        <div class="stat-box">
                            <h2>24M+</h2>
                            <p>Project Tasks Logged</p>
                        </div>
                    </div>
                    <div class="col-md-3" data-aos="zoom-in" data-aos-delay="100">
                        <div class="stat-box">
                            <h2>150K+</h2>
                            <p>Active Professionals</p>
                        </div>
                    </div>
                    <div class="col-md-3" data-aos="zoom-in" data-aos-delay="200">
                        <div class="stat-box">
                            <h2>1,400+</h2>
                            <p>Enterprise Environments</p>
                        </div>
                    </div>
                    <div class="col-md-3" data-aos="zoom-in" data-aos-delay="300">
                        <div class="stat-box">
                            <h2>99.9%</h2>
                            <p>Platform Infrastructure Uptime</p>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- Pricing Tier Structure Block -->
        <section id="pricing" class="bg-white">
            <div class="container">
                <div class="section-title" data-aos="fade-up">
                    <span>Flexible Investments</span>
                    <h2>Scalable Subscription Frameworks</h2>
                    <p>Choose a billing tier adjusted perfectly around your organization's precise scale and feature requirements.</p>
                </div>

                <div class="row g-4 align-items-center">
                    <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                        <div class="pricing-card">
                            <h5 class="fw-bold mb-2 text-muted">Starter Sandbox</h5>
                            <p class="small text-muted mb-4">Perfect for small teams tracking foundational items.</p>
                            <div class="price mb-4"><h3>$0 <span>/ forever</span></h3></div>
                            <hr />
                            <ul class="list-unstyled my-4 text-muted small" style="line-height:2.2;">
                                <li><i class="bi bi-check text-primary me-2"></i> Up to 5 Active Members</li>
                                <li><i class="bi bi-check text-primary me-2"></i> Standard Kanban Interface</li>
                                <li><i class="bi bi-check text-primary me-2"></i> 1GB Global Document Storage</li>
                            </ul>
                            <a href="Register.aspx" class="btn btn-outline-dark rounded-pill w-100 py-2 mt-2">Get Started</a>
                        </div>
                    </div>

                    <div class="col-lg-4" data-aos="fade-up">
                        <div class="pricing-card popular">
                            <div class="popular-badge">Most Requested</div>
                            <h5 class="fw-bold mb-2 text-primary">Professional Sync</h5>
                            <p class="small text-muted mb-4">Optimized for expanding teams and advanced analytics tracking.</p>
                            <div class="price mb-4"><h3>$12 <span>/ user / mo</span></h3></div>
                            <hr />
                            <ul class="list-unstyled my-4 small" style="line-height:2.2;">
                                <li><i class="bi bi-check text-primary me-2"></i> Unlimited Workspace Additions</li>
                                <li><i class="bi bi-check text-primary me-2"></i> Full Analytical Dashboard Access</li>
                                <li><i class="bi bi-check text-primary me-2"></i> 50GB Shared Cloud Storage Space</li>
                                <li><i class="bi bi-check text-primary me-2"></i> Direct Priority API Connections</li>
                            </ul>
                            <a href="Register.aspx" class="btn btn-primary rounded-pill w-100 py-2 mt-2" style="background:#2563eb; border:none;">Launch Professional Trial</a>
                        </div>
                    </div>

                    <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                        <div class="pricing-card">
                            <h5 class="fw-bold mb-2 text-muted">Enterprise Grid</h5>
                            <p class="small text-muted mb-4">Custom configurations for corporate compliance demands.</p>
                            <div class="price mb-4"><h3>Custom <span>/ customized</span></h3></div>
                            <hr />
                            <ul class="list-unstyled my-4 text-muted small" style="line-height:2.2;">
                                <li><i class="bi bi-check text-primary me-2"></i> Dedicated Server Channels</li>
                                <li><i class="bi bi-check text-primary me-2"></i> Custom SAML/SSO Validations</li>
                                <li><i class="bi bi-check text-primary me-2"></i> 24/7 Dedicated Support Engineers</li>
                            </ul>
                            <a href="#about" class="btn btn-outline-dark rounded-pill w-100 py-2 mt-2">Contact Sales Ecosystem</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Social Validation Area -->
        <section class="bg-light">
            <div class="container">
                <div class="section-title" data-aos="fade-up">
                    <span>Verified Testimonials</span>
                    <h2>Trusted by Forward-Thinking Operations</h2>
                    <p>See how teams use TeamSync to transform their daily project management workflow.</p>
                </div>

                <div class="row g-4">
                    <div class="col-lg-4" data-aos="fade-up">
                        <div class="testimonial-card">
                            <div class="user-meta">
                                <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Rahul Sharma portrait" />
                                <div>
                                    <h5>Rahul Sharma</h5>
                                    <span>Engineering Lead, TechVantage</span>
                                </div>
                            </div>
                            <p>“TeamSync centralized our sprint boards beautifully. The code deployment status updates that used to get lost across emails are now tracked neatly right within our main dashboards.”</p>
                        </div>
                    </div>
                    <div class="col-lg-4" data-aos="fade-up" data-aos-delay="100">
                        <div class="testimonial-card">
                            <div class="user-meta">
                                <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Priya Verma portrait" />
                                <div>
                                    <h5>Priya Verma</h5>
                                    <span>Product Strategist, PixelFlow</span>
                                </div>
                            </div>
                            <p>“The interface design provides excellent usability. Our cross-functional creative teams picked up the task boards immediately, reducing our project onboarding timeframe by nearly half.”</p>
                        </div>
                    </div>
                    <div class="col-lg-4" data-aos="fade-up" data-aos-delay="200">
                        <div class="testimonial-card">
                            <div class="user-meta">
                                <img src="https://randomuser.me/api/portraits/men/52.jpg" alt="Amit Kumar portrait" />
                                <div>
                                    <h5>Amit Kumar</h5>
                                    <span>Operations Director, CoreBuild</span>
                                </div>
                            </div>
                            <p>“The automated notifications system provides fantastic clarity. Everyone stays aligned on exactly what dependencies are blocking high-priority tasks without needing constant check-in meetings.”</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Informational FAQ Infrastructure Block -->
        <section class="bg-white">
            <div class="container" style="max-width: 800px;">
                <div class="section-title" data-aos="fade-up">
                    <span>Answering Common Questions</span>
                    <h2>Frequently Asked Questions</h2>
                </div>

                <div class="accordion" id="faqAccordion" data-aos="fade-up">
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">
                                Can I switch plans as our operational team sizing shifts?
                            </button>
                        </h2>
                        <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                Yes. You can upgrade, downgrade, or scale seat capacity variables instantly via your corporate profile billing configurations panel at any point during active service cycles.
                            </div>
                        </div>
                    </div>

                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">
                                Does TeamSync provide on-premise dedicated deployments?
                            </button>
                        </h2>
                        <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                            <div class="accordion-body text-muted">
                                On-premise configurations and isolated custom network structures are available exclusively via our Enterprise Grid plan. Get in touch with our architecture team for more details.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Workspace Link Architecture Directory -->
        <section class="links-section bg-light" id="links">
            <div class="container">
                <div class="section-title" data-aos="fade-up">
                    <span>System Architecture Navigation</span>
                    <h2>Application Directory Routing</h2>
                    <p>Quickly access core platform workspace nodes and setup endpoints from this central navigation matrix.</p>
                </div>

                <div class="row g-3">
                    <div class="col-xl-3 col-md-6" data-aos="zoom-in"><a href="Login.aspx" class="useful-link-card"><i class="bi bi-box-arrow-in-right"></i><span>Login Gateway</span></a></div>
                    <div class="col-xl-3 col-md-6" data-aos="zoom-in" data-aos-delay="50"><a href="Register.aspx" class="useful-link-card"><i class="bi bi-person-plus-fill"></i><span>Workspace Registration</span></a></div>
                    <div class="col-xl-3 col-md-6" data-aos="zoom-in" data-aos-delay="100"><a href="User/Dashboard.aspx" class="useful-link-card"><i class="bi bi-grid-fill"></i><span>Central Analytics</span></a></div>
                    <div class="col-xl-3 col-md-6" data-aos="zoom-in" data-aos-delay="150"><a href="User/MyTasks.aspx" class="useful-link-card"><i class="bi bi-list-task"></i><span>Personal Task Desk</span></a></div>
                    <div class="col-xl-3 col-md-6" data-aos="zoom-in"><a href="User/Projects.aspx" class="useful-link-card"><i class="bi bi-kanban-fill"></i><span>Project Pipelines</span></a></div>
                    <div class="col-xl-3 col-md-6" data-aos="zoom-in" data-aos-delay="50"><a href="User/Calendar.aspx" class="useful-link-card"><i class="bi bi-calendar2-week-fill"></i><span>Milestone Calendars</span></a></div>
                    <div class="col-xl-3 col-md-6" data-aos="zoom-in" data-aos-delay="100"><a href="User/Notifications.aspx" class="useful-link-card"><i class="bi bi-bell-fill"></i><span>Notification Hub</span></a></div>
                    <div class="col-xl-3 col-md-6" data-aos="zoom-in" data-aos-delay="150"><a href="User/Profile.aspx" class="useful-link-card"><i class="bi bi-person-circle"></i><span>User Profile Desk</span></a></div>
                </div>
            </div>
        </section>

        <!-- Global Footer Block -->
        <footer>
            <div class="container">
                <div class="row g-4 text-start">
                    <div class="col-lg-5">
                        <h4 class="text-white mb-3">TeamSync</h4>
                        <p style="max-width: 350px; line-height: 1.8;">Comprehensive collaborative toolsets built intentionally to optimize tracking metrics, operational clarity, and high-performance cross-functional delivery streams.</p>
                    </div>
                    <div class="col-sm-3 col-6 ms-auto">
                        <h6 class="text-white fw-bold mb-3">Workspace Platform</h6>
                        <ul class="list-unstyled" style="line-height:2.2;">
                            <li><a href="#features">Feature Suite</a></li>
                            <li><a href="#pricing">Billing Tiers</a></li>
                            <li><a href="Login.aspx">Client Portal Logins</a></li>
                        </ul>
                    </div>
                    <div class="col-sm-3 col-6">
                        <h6 class="text-white fw-bold mb-3">Engineering Links</h6>
                        <ul class="list-unstyled" style="line-height:2.2;">
                            <li><a href="https://s4ch1nroy.web.app/" target="_blank">Sachin Kumar Profile</a></li>
                            <li><a href="#links">Directory Mapping</a></li>
                        </ul>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p class="mb-0">© 2026 TeamSync Enterprise Network Systems. Built by <a href="https://s4ch1nroy.web.app/" target="_blank" class="text-primary fw-semibold">Sachin Kumar</a>. All Rights Reserved.</p>
                </div>
            </div>
        </footer>

    </form>

    <!-- Script Implementations -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
    <script>
        AOS.init({
            duration: 900,
            once: true
        });
    </script>
</body>
</html>