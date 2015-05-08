From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: earlycon: no match?
Date: Fri, 8 May 2015 08:34:33 +0200
Message-ID: <20150508063433.GA6325@pengutronix.de>
References: <20150503211054.GR15254@pengutronix.de>
 <55477BC1.6000805@hurleysoftware.com>
 <20150504194229.GR15254@pengutronix.de>
 <5547D4DB.8060300@hurleysoftware.com>
 <20150504205241.GT15254@pengutronix.de>
 <5547E447.9020604@hurleysoftware.com>
 <alpine.LFD.2.11.1505071749370.1538@eddie.linux-mips.org>
 <554B9F43.6000702@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <554B9F43.6000702@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, kernel@pengutronix.de, Robert Schwebel <r.schwebel@pengutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 07, 2015 at 01:22:11PM -0400, Peter Hurley wrote:
> On 05/07/2015 01:09 PM, Maciej W. Rozycki wrote:
> > On Mon, 4 May 2015, Peter Hurley wrote:
> > 
> >>>> Since 2007, 'console=' is a early param synonym for 'earlycon='; IOW,
> >>>> the message is new but not the behavior.
> >>>
> >>> "console=" had nothing to do with early param before.
> >>
> >> *Yes, it has* since the commit I referenced in the previous email and
> >> the email before that when I noted that 'console=' and 'earlycon=' are
> >> synonyms if CONFIG_SERIAL_EARLYCON=y, and it has been that way since
> >> 2007.
> >>
> >> The only thing that has changed is that I added a diagnostic; _to repeat_,
> >> the earlycon matching code has always run in this case, only the
> >> diagnostic is new.
> > 
> >  What's the point of having two parameters as synonyms whose syntax is not 
> > compatible to each other in the general case?  I'd expect the following 
> > cases to be handled:
> > 
> > 1. Regular console only (no early console requested) => `console=foo...'.
> > 
> > 2. Both early and regular console => `earlycon=blah... console=foo...'.
> > 
> > 3. Early console handing over to regular console => `earlycon=blah...'.
> 
>   4. Early console only => `earlycon=blah...'
> 
> How to distinguish between 3 & 4?

Given that the aliasing only makes sense for console=uart, and
console=uart8250, we can do the following. Not exactly the nicest
code, but only slighty more ugly than what we have now in
do_early_param()

Sascha

--------------------------8<----------------------------

>From e4d5a09877e48308ee0cf4170f2eef8aa2f747f5 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 8 May 2015 08:23:47 +0200
Subject: [PATCH] param: console: Do not treat console as synonym for earlycon

Since 2007 console= and earlycon= are treated as synonyms, but the
syntax for both options is different. The only case in which they
are identical is for console=uart or console=uart8250. All other
cases currently lead to the warning:

earlycon: no match for xxx

This patch drops the general aliasing, but keeps the current
behaviour for console=uart and console=uart8250 to keep the kernel
parameters compatible.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 init/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 2115055..bfcbbc5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -413,12 +413,15 @@ static noinline void __init_refok rest_init(void)
 static int __init do_early_param(char *param, char *val, const char *unused)
 {
 	const struct obs_kernel_param *p;
+	bool earlyconalias = false;
+
+	if (val && !strcmp(param, "console") &&
+	    (!strncmp(val, "uart,", 5) || !strncmp(val, "uart8250,", 9)))
+		earlyconalias = true;
 
 	for (p = __setup_start; p < __setup_end; p++) {
 		if ((p->early && parameq(param, p->str)) ||
-		    (strcmp(param, "console") == 0 &&
-		     strcmp(p->str, "earlycon") == 0)
-		) {
+		    (earlyconalias && strcmp(p->str, "earlycon") == 0)) {
 			if (p->setup_func(val) != 0)
 				pr_warn("Malformed early option '%s'\n", param);
 		}
-- 
2.1.4

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
