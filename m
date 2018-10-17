From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Wed, 17 Oct 2018 03:13:55 -0700
Message-ID: <20181017101355.GA230639@joelaf.mtv.corp.google.com>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Hi Kees,

On Tue, Oct 16, 2018 at 10:02:53AM -0700, Kees Cook wrote:
> On Tue, Oct 16, 2018 at 8:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 16 Oct 2018 17:08:25 +0530
> > Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> >> One more thing is for pstore dmesg-ramoops, I had to change
> >> late_initcall to postcore_initcall which brings the question as to why
> >> we changed to late_initcall?
> >> Simple git blame shows to support crypto compress api, but is it really
> >> helpful? A lot of boottime issues can be caught with pstore enabled at
> >> postcore_initcall rather than late_initcall, this backtrace
> >> is just one example. Is there any way we could change this?
> >
> > Does it break if the crypto is not initialized? Perhaps add a command
> > line flag to have it happen earlier:
> >
> >  ramoops=earlyinit
> >
> > and add a postcore_initcall that checks if that flag is set, and if so,
> > it does the work then, and the late_initcall() will do nothing.
> >
> > That way, you can still have unmodified kernels use pstore when it
> > crashes at boot up.
> 
> Even better, if we could find a way to make it work with a late
> initialization of compression (i.e. postcore_initcall() by default
> means anything caught would be uncompressed, but anything after
> late_initcall() would be compressed). I'd be very happy to review
> patches for that!

What do you think about the (untested) patch below? It seems to me that it
should solve the issue of missing early crash dumps, but I have not tested it
yet. Sai, would you mind trying it out and let me know if you can see the
early crash dumps properly now?

----8<---
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC] pstore: allocate compression during late_initcall

ramoop's pstore registration (using pstore_register) has to run during
late_initcall because crypto backend may not be ready during
postcore_initcall. This causes missing of dmesg crash dumps which could
have been caught by pstore.

Instead, lets allow ramoops pstore registration earlier, and once crypto
is ready we can initialize the compression.

Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/platform.c | 13 +++++++++++++
 fs/pstore/ram.c      |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 15e99d5a681d..f09066db2d4d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -780,6 +780,19 @@ void __init pstore_choose_compression(void)
 	}
 }
 
+static int __init pstore_compression_late_init(void)
+{
+	/*
+	 * Check if any pstore backends registered earlier but did not allocate
+	 * for compression because crypto was not ready, if so then initialize
+	 * compression.
+	 */
+	if (psinfo && !tfm)
+		allocate_buf_for_compression();
+	return 0;
+}
+late_initcall(pstore_compression_late_init);
+
 module_param(compress, charp, 0444);
 MODULE_PARM_DESC(compress, "Pstore compression to use");
 
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bbd1e357c23d..98e48d1a9776 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -940,7 +940,7 @@ static int __init ramoops_init(void)
 	ramoops_register_dummy();
 	return platform_driver_register(&ramoops_driver);
 }
-late_initcall(ramoops_init);
+postcore_initcall(ramoops_init);
 
 static void __exit ramoops_exit(void)
 {
-- 
2.19.1.331.ge82ca0e54c-goog
