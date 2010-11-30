From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: 8250 Serial console unusable
Date: Tue, 30 Nov 2010 15:46:14 +0100
Message-ID: <1291128374.18297.75.camel@hammer.site>
References: <AANLkTimGPcuksdcwq73rDT6V1Xpyjm2qBGVc5MTgej7t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56034 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab0K3OqR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Nov 2010 09:46:17 -0500
In-Reply-To: <AANLkTimGPcuksdcwq73rDT6V1Xpyjm2qBGVc5MTgej7t@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-serial@vger.kernel.org, jason77.wang@gmail.com, alan@linux.intel.com, arnd@arndb.de

Daniel Drake wrote:
> It
> looks like Stanislav works with machines with a similar requirement,
> which I guess suffer the same problem in Linus master:

Zaurus machines. Well, the current vanilla does not work with
no_console_suspend on Zaurus as well.

Changing
if (console_suspend_enabled || !uart_console(uport)) {
in resume process just above the line
/* Protected by port mutex for now */
to
if (1) {
makes resume working with no_console_suspend again. So one of lines
inside does something important.

I never sent this patch to the list, because I suspect, that would brea=
k
other machines in this simple stupid form.

> What's the right way to go around solving this, that doesn't step on
> anyones toes?

Try to find exact instruction that needs to be called. See the topic
"[PATCH RESEND 0/2] two serial_core suspend/resume fixes".

> From an ignorant high-level perspective, it doesn't sound unreasonabl=
e
> or complicated to simply unconditionally restore the correct port
> configuration on resume. I'm having trouble understanding the argumen=
t
> against this perspective presented in commit 891b9dd10.

You cannot do it. There may exist a hardware, where resume depends on
suspend previously called. But it does not happen with
no_console_suspend. You have to find a subset, that is able to set
console to working state without suspend/resume disparity.

Maybe adding non-stopping save/restore in addition to suspend/resume in
all drivers may be cleaner solution.

--=20
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarsk=C3=A1 1060/12           tel: +420 284 028 966, +49 911 740538=
747
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
