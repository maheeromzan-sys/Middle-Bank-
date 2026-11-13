/// Every string as [English, Bangla].
const Map<String, List<String>> kStrings = {
  // ---- common ----
  'slogan': ['Your Money, Your Security.', 'আপনার অর্থ, আপনার নিরাপত্তা।'],
  'demo_banner': [
    'Prototype only — demo data, no real money',
    'প্রোটোটাইপ মাত্র — ডেমো ডেটা, কোনো প্রকৃত অর্থ নয়'
  ],
  'loading': ['Loading securely…', 'নিরাপদে লোড হচ্ছে…'],
  'buyer': ['Buyer', 'ক্রেতা'],
  'seller': ['Seller', 'বিক্রেতা'],
  'login': ['Login', 'লগইন'],
  'create_account': ['Create Account', 'অ্যাকাউন্ট খুলুন'],
  'continue_as': ['or Continue as', 'অথবা চালিয়ে যান'],
  'continue_buyer': ['Continue as Buyer', 'ক্রেতা হিসেবে চালিয়ে যান'],
  'continue_seller': ['Continue as Seller', 'বিক্রেতা হিসেবে চালিয়ে যান'],
  'safe_secure': ['Safe & Secure Transaction', 'নিরাপদ ও সুরক্ষিত লেনদেন'],
  'buy_sell': ['Buy and Sell with Confidence', 'আস্থার সাথে কেনা-বেচা করুন'],
  'secure_payment': ['Secure Payment', 'নিরাপদ পেমেন্ট'],
  'txn_receipt': ['Transaction Receipt', 'লেনদেনের রসিদ'],
  'track_txn': ['Track Transaction', 'লেনদেন ট্র্যাক'],
  'support': ['Customer Support', 'কাস্টমার সাপোর্ট'],
  'cancel': ['Cancel', 'বাতিল'],
  'confirm': ['Confirm', 'নিশ্চিত করুন'],
  'v_required': ['This field is required', 'এই ঘরটি পূরণ করুন'],

  // ---- login / register ----
  'welcome_back': ['Welcome back', 'আবার স্বাগতম'],
  'login_sub': ['Login to continue', 'চালিয়ে যেতে লগইন করুন'],
  'mobile': ['Mobile Number', 'মোবাইল নম্বর'],
  'password': ['Password', 'পাসওয়ার্ড'],
  'forgot': ['Forgot Password?', 'পাসওয়ার্ড ভুলে গেছেন?'],
  'forgot_demo': [
    'Demo: password reset is not connected',
    'ডেমো: পাসওয়ার্ড রিসেট সংযুক্ত নয়'
  ],
  'new_account': ['Create New Account', 'নতুন অ্যাকাউন্ট খুলুন'],
  'login_as': ['Login as', 'যে ভূমিকায় লগইন'],
  'v_mobile': [
    'Enter a valid 11-digit mobile number',
    'সঠিক ১১ সংখ্যার মোবাইল নম্বর দিন'
  ],
  'v_pass': [
    'Password must be at least 6 characters',
    'পাসওয়ার্ড কমপক্ষে ৬ অক্ষরের হতে হবে'
  ],
  'create_account_sub': [
    'Join MIDDLE BANK in a minute',
    'এক মিনিটেই MIDDLE BANK-এ যোগ দিন'
  ],
  'full_name': ['Full Name', 'পূর্ণ নাম'],
  'email': ['Email Address', 'ইমেইল ঠিকানা'],
  'confirm_password': ['Confirm Password', 'পাসওয়ার্ড নিশ্চিত করুন'],
  'register_btn': ['Register', 'রেজিস্টার করুন'],
  'v_email': ['Enter a valid email address', 'সঠিক ইমেইল ঠিকানা দিন'],
  'v_match': ['Passwords do not match', 'পাসওয়ার্ড মিলছে না'],
  'have_account': [
    'Already have an account? Login',
    'আগে থেকেই অ্যাকাউন্ট আছে? লগইন করুন'
  ],
  'account_created': [
    'Demo account created',
    'ডেমো অ্যাকাউন্ট তৈরি হয়েছে'
  ],

  // ---- dashboards / nav ----
  'hello': ['Welcome', 'স্বাগতম'],
  'buyer_sub': ['What would you like to do today?', 'আজ কী করতে চান?'],
  'new_txn': ['Create New Transaction', 'নতুন লেনদেন তৈরি'],
  'my_txns': ['My Transactions', 'আমার লেনদেন'],
  'recent': ['Recent Transactions', 'সাম্প্রতিক লেনদেন'],
  'view_all': ['View all', 'সব দেখুন'],
  'escrow_demo': [
    'Protected in escrow (demo)',
    'এসক্রোতে সুরক্ষিত (ডেমো)'
  ],
  'nav_home': ['Home', 'হোম'],
  'nav_txns': ['Transactions', 'লেনদেন'],
  'nav_track': ['Track', 'ট্র্যাক'],
  'nav_support': ['Support', 'সাপোর্ট'],
  'nav_incoming': ['Incoming', 'আগত'],
  'nav_history': ['History', 'ইতিহাস'],
  'no_txns': ['No transactions yet', 'এখনো কোনো লেনদেন নেই'],
  'seller_profile': ['Seller Profile', 'বিক্রেতার প্রোফাইল'],
  'verified_seller': ['Verified Seller (demo)', 'যাচাইকৃত বিক্রেতা (ডেমো)'],
  'incoming': ['Incoming Transactions', 'আগত লেনদেন'],
  'pay_sec_status': ['Payment Security Status', 'পেমেন্ট নিরাপত্তা স্ট্যাটাস'],
  'delivery_status': ['Delivery Status', 'ডেলিভারি স্ট্যাটাস'],
  'history': ['Transaction History', 'লেনদেনের ইতিহাস'],
  'release_status': ['Payment Release Status', 'পেমেন্ট রিলিজ স্ট্যাটাস'],
  'all_secure': ['All payments protected', 'সব পেমেন্ট সুরক্ষিত'],
  'funds_held': ['Held in escrow', 'এসক্রোতে রয়েছে'],
  'released_total': ['Released to you', 'আপনার কাছে রিলিজ হয়েছে'],
  'mark_shipped': ['Mark as Shipped', 'পাঠানো হয়েছে চিহ্নিত করুন'],
  'mark_delivered': ['Mark as Delivered', 'পৌঁছেছে চিহ্নিত করুন'],
  'awaiting_buyer': ['Waiting for buyer', 'ক্রেতার অপেক্ষায়'],
  'awaiting_pay': ['Waiting for payment', 'পেমেন্টের অপেক্ষায়'],
  'to_ship': ['To ship', 'পাঠাতে হবে'],
  'in_transit': ['In transit', 'পথে আছে'],
  'ready_release': ['Release pending', 'রিলিজ বাকি'],

  // ---- txn status ----
  'st_wait_pay': ['Awaiting payment', 'পেমেন্টের অপেক্ষায়'],
  'st_held': ['Paid — held in escrow', 'পরিশোধিত — এসক্রোতে সুরক্ষিত'],
  'st_shipped': ['Shipped', 'পাঠানো হয়েছে'],
  'st_delivered': ['Delivered', 'পৌঁছেছে'],
  'st_buyer_ok': ['Buyer confirmed', 'ক্রেতা নিশ্চিত'],
  'st_released': ['Payment released', 'পেমেন্ট রিলিজড'],

  // ---- create transaction ----
  'create_title': ['Create Transaction', 'লেনদেন তৈরি'],
  'seller_info': ['Seller Information', 'বিক্রেতার তথ্য'],
  'seller_name': ['Seller Name', 'বিক্রেতার নাম'],
  'seller_mobile': ['Seller Mobile', 'বিক্রেতার মোবাইল'],
  'product_info': ['Product', 'পণ্য'],
  'product_name': ['Product Name', 'পণ্যের নাম'],
  'product_price': ['Product Price (৳)', 'পণ্যের মূল্য (৳)'],
  'txn_id': ['Transaction ID', 'লেনদেন আইডি'],
  'auto_generated': ['Auto-generated', 'স্বয়ংক্রিয়ভাবে তৈরি'],
  'delivery_info': ['Delivery Information', 'ডেলিভারির তথ্য'],
  'delivery_hint': ['Address and delivery notes', 'ঠিকানা ও ডেলিভারি নোট'],
  'create_btn': ['Create Transaction', 'লেনদেন তৈরি করুন'],
  'v_price': ['Enter a valid price', 'সঠিক মূল্য দিন'],

  // ---- secure payment ----
  'txn_details': ['Transaction Details', 'লেনদেনের বিবরণ'],
  'payment_status': ['Payment Status', 'পেমেন্ট স্ট্যাটাস'],
  'payment_method': ['Payment Method', 'পেমেন্ট পদ্ধতি'],
  'status_pending': ['Pending', 'অপেক্ষমাণ'],
  'status_confirmed': ['Confirmed (demo)', 'নিশ্চিত (ডেমো)'],
  'method_partner': [
    'Approved Payment Partner (demo)',
    'অনুমোদিত পেমেন্ট পার্টনার (ডেমো)'
  ],
  'method_wallet': ['Mobile Wallet (demo)', 'মোবাইল ওয়ালেট (ডেমো)'],
  'method_card': ['Card (demo)', 'কার্ড (ডেমো)'],
  'demo_pay_confirm': ['Demo Payment Confirmation', 'ডেমো পেমেন্ট নিশ্চিতকরণ'],
  'no_real_money': [
    'No real money is charged. This is a simulation.',
    'কোনো প্রকৃত অর্থ কাটা হবে না। এটি একটি সিমুলেশন।'
  ],
  'amount': ['Amount', 'পরিমাণ'],
  'product': ['Product', 'পণ্য'],
  'delivery': ['Delivery', 'ডেলিভারি'],
  'confirm_title': ['Confirm demo payment?', 'ডেমো পেমেন্ট নিশ্চিত করবেন?'],
  'confirm_body': [
    'This only simulates paying into escrow. Nothing is charged.',
    'এটি শুধু এসক্রোতে পেমেন্টের সিমুলেশন। কিছুই কাটা হবে না।'
  ],
  'already_paid': ['Payment already confirmed', 'পেমেন্ট ইতিমধ্যে নিশ্চিত'],
  'pick_txn': ['Select a transaction first', 'আগে একটি লেনদেন নির্বাচন করুন'],
  'pick_one': ['Choose a transaction', 'একটি লেনদেন বেছে নিন'],

  // ---- receipt ----
  'unique_id': ['Unique Transaction ID', 'অনন্য লেনদেন আইডি'],
  'buyer_details': ['Buyer Details', 'ক্রেতার তথ্য'],
  'seller_details': ['Seller Details', 'বিক্রেতার তথ্য'],
  'name': ['Name', 'নাম'],
  'date_time': ['Date and Time', 'তারিখ ও সময়'],
  'download_receipt': ['Download Receipt', 'রসিদ ডাউনলোড'],
  'receipt_copied': [
    'Receipt text copied (demo). PDF export needs the pdf package.',
    'রসিদের লেখা কপি হয়েছে (ডেমো)। PDF-এর জন্য pdf প্যাকেজ লাগবে।'
  ],
  'demo_receipt': ['DEMO RECEIPT', 'ডেমো রসিদ'],

  // ---- track ----
  's_created': ['Transaction Created', 'লেনদেন তৈরি হয়েছে'],
  's_paid': ['Payment Confirmed', 'পেমেন্ট নিশ্চিত হয়েছে'],
  's_shipped': ['Product Shipped', 'পণ্য পাঠানো হয়েছে'],
  's_delivered': ['Product Delivered', 'পণ্য পৌঁছেছে'],
  's_buyer_ok': ['Buyer Confirmed', 'ক্রেতা নিশ্চিত করেছেন'],
  's_released': ['Payment Released', 'পেমেন্ট রিলিজ হয়েছে'],
  'demo_next': ['Demo: move to next step', 'ডেমো: পরের ধাপে যান'],
  'all_done': ['All steps completed', 'সব ধাপ সম্পন্ন'],
  'step_done': ['Done', 'সম্পন্ন'],
  'step_now': ['In progress', 'চলমান'],
  'step_wait': ['Pending', 'বাকি'],

  // ---- support ----
  'help_center': ['Help Center', 'হেল্প সেন্টার'],
  'help_sub': [
    'Guides on escrow, payments and delivery',
    'এসক্রো, পেমেন্ট ও ডেলিভারি বিষয়ক গাইড'
  ],
  'faq': ['Frequently Asked Questions', 'সচরাচর জিজ্ঞাসা'],
  'contact_support': ['Contact Support', 'সাপোর্টে যোগাযোগ'],
  'submit_complaint': ['Submit a Complaint', 'অভিযোগ জমা দিন'],
  'c_call': ['Call (demo number)', 'কল (ডেমো নম্বর)'],
  'c_email': ['Email', 'ইমেইল'],
  'c_hours': ['Sat–Thu, 9:00 AM – 9:00 PM', 'শনি–বৃহস্পতি, সকাল ৯টা – রাত ৯টা'],
  'complaint_subject': ['Subject', 'বিষয়'],
  'complaint_msg': ['Describe your issue', 'আপনার সমস্যা লিখুন'],
  'submit': ['Submit', 'জমা দিন'],
  'ticket_ok': ['Demo complaint submitted', 'ডেমো অভিযোগ জমা হয়েছে'],
  'subj_payment': ['Payment issue', 'পেমেন্ট সমস্যা'],
  'subj_delivery': ['Delivery issue', 'ডেলিভারি সমস্যা'],
  'subj_other': ['Other', 'অন্যান্য'],
  'q1': ['How does escrow work?', 'এসক্রো কীভাবে কাজ করে?'],
  'a1': [
    'The buyer pays through an approved payment partner. The seller ships only after payment is confirmed. When the buyer confirms delivery, the payment is released to the seller.',
    'ক্রেতা অনুমোদিত পেমেন্ট পার্টনারের মাধ্যমে পেমেন্ট করেন। পেমেন্ট নিশ্চিত হলে বিক্রেতা পণ্য পাঠান। ক্রেতা ডেলিভারি নিশ্চিত করলে পেমেন্ট বিক্রেতার কাছে রিলিজ হয়।'
  ],
  'q2': ['Does MIDDLE BANK hold my money?', 'MIDDLE BANK কি আমার টাকা রাখে?'],
  'a2': [
    'In this prototype, no. All payments are simulated with demo data and no real money moves.',
    'এই প্রোটোটাইপে না। সব পেমেন্ট ডেমো ডেটা দিয়ে সিমুলেট করা, কোনো প্রকৃত অর্থ লেনদেন হয় না।'
  ],
  'q3': ['What if the product is not delivered?', 'পণ্য না পৌঁছালে কী হবে?'],
  'a3': [
    'Do not confirm delivery. Submit a complaint from this screen and the support team will review the transaction.',
    'ডেলিভারি নিশ্চিত করবেন না। এই স্ক্রিন থেকে অভিযোগ জমা দিন, সাপোর্ট টিম লেনদেনটি পর্যালোচনা করবে।'
  ],
  'q4': ['How do I track my order?', 'অর্ডার কীভাবে ট্র্যাক করব?'],
  'a4': [
    'Open Track Transaction to see all six steps from creation to payment release.',
    'তৈরি থেকে পেমেন্ট রিলিজ পর্যন্ত ছয়টি ধাপ দেখতে লেনদেন ট্র্যাক খুলুন।'
  ],
};
