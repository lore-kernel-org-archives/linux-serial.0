From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: [RFC] firmware: annotate thou shalt not request fw on init or probe
Date: Tue, 1 Sep 2015 13:28:27 -0400
Message-ID: <CA+5PVA6toGj5iboTgK5Casy9vUAQC8SXYWKEx+ojwC51UEV0HA@mail.gmail.com>
References: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Ming Lei <ming.lei@canonical.com>, Julia Lawall <julia.lawall@lip6.fr>, Linus Torvalds <torvalds@linux-foundation.org>, liam.r.girdwood@linux.intel.com, yang.jie@intel.com, Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, joonas.lahtinen@linux.intel.com, Tom Gundersen <teg@jklm.no>, Alexander Viro <viro@zeniv.linux.org.uk>, Greg KH <gregkh@linuxfoundation.org>, Kay Sievers <kay@vrfy.org>, David Woodhouse <dwmw2@infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, yalin.wang2010@gmail.com, "Luis R. Rodriguez" <mcgrof@suse.com>, Jonathan Corbet <corbet@lwn.net>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, linux-doc@vger.kernel.org, cocci@systeme.lip6.fr, Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@su>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 28, 2015 at 9:18 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> We are phasing out the usermode helper from the kernel,
> systemd already ripped support for this a while ago, the
> only remaining valid user is the Dell rbu driver. The

Actually, I don't think that is accurate any longer.  The Dell rbu
driver certainly requires this, but it seems that the following
drivers select FW_LOADER_USER_HELPER_FALLBACK as well:

CONFIG_DRM_STI
CONFIG_LEDS_LP55XX_COMMON

Why they do that, I have no idea.  It's kind of disappointing.

josh
