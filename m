From: Red Hat Product Security <secalert@redhat.com>
Subject: [engineering.redhat.com #494100] Question on submitting patch for a security bug
Date: Mon, 5 Aug 2019 13:38:48 -0400
Message-ID: <rt-4.0.13-23214-1565026728-1358.494100-5-0@engineering.redhat.com>
References: <RT-Ticket-494100@engineering.redhat.com>
 <CAJ7L_Gp2HJoFOVxTgakCJw3LMuiPY0+60-giOtw3OwRD6zyNTQ@mail.gmail.com>
Reply-To: secalert@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJ7L_Gp2HJoFOVxTgakCJw3LMuiPY0+60-giOtw3OwRD6zyNTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b.zolnierkie@samsung.com, bob.liu@oracle.com, chuck.lever@oracle.com, davem@davemloft.net, emamd001@umn.edu, gregkh@linuxfoundation.org, kubakici@wp.pl, kvalo@codeaurora.org, navid.emamdoost@gmail.com, sam@ravnborg.org
Cc: airlied@linux.ie, alexandre.belloni@bootlin.com, alexandre.torgue@st.com, allison@lohutok.net, andriy.shevchenko@linux.intel.com, anna.schumaker@netapp.com, axboe@kernel.dk, bfields@fieldses.org, colin.king@canonical.com, daniel@ffwll.ch, devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org, joabreu@synopsys.com, johnfwhitmore@gmail.com, josef@toxicpanda.com, jslaby@suse.com, kjlu@umn.edu, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-nfs@vger.kernel.org, linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org, matthias.bgg@gmail.com, matthias@redhat.com, mcoquelin.stm32@gm
List-Id: linux-serial@vger.kernel.org

Hello Navid,

On Thu, 18 Jul 2019 01:30:20 GMT, emamd001@umn.edu wrote:
> I've found a null dereference bug in the Linux kernel source code. I was
> wondering should I cc the patch to you as well (along with the
> maintainers)?

No. Please do not cc <secalert@redhat.com> on the upstream kernel patches.
It is meant for reporting security issues only.

Going through the patches here

1. Issues in ../staging/ drivers are not considered for CVE, they are not to be
used
in production environment.

2. Many of the patches listed fix NULL pointer dereference when memory
allocation
fails and returns NULL.

3. Do you happen to have reproducers for these issues? Could an unprivileged
user trigger them?

> Also, I was wondering what are the steps to get CVE for the bug (this is
> the first time I am reporting a bug)?

Generally CVE is assigned after confirming that a given issue really is a
security issue. And it may
have impact ranging from information leakage, DoS to privilege escalation or
maybe arbitrary code
execution. Every NULL pointer dereference is not security issue.


Hope it helps. Thank you.
---
Prasad J Pandit / Red Hat Product Security Team
