From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] Revert "serial: 8250_dma: don't bother DMA with small transfers"
Date: Fri, 9 Oct 2015 12:09:21 -0300
Message-ID: <CAOMZO5BaXzwMGhdOOLLJU1f37HsmH3309MG5qBEmKubL=kPn_A@mail.gmail.com>
References: <1444136920-17969-1-git-send-email-frederic.danis@linux.intel.com>
	<20151006135503.GA13250@kroah.com>
	<5613D968.7000505@linux.intel.com>
	<5617D2FA.1020108@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5617D2FA.1020108-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 9, 2015 at 11:45 AM, Frederic Danis
<frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> This is first time for me that patch may be applied to previous kernel.
>
> Is there something specific I should do to allow this patch to be applied
> and backported to 4.0 and newer ?

You can find the instructions at Documentation/stable_kernel_rules.txt
