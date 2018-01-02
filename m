From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] serial: imx: fix endless loop during suspend
Date: Tue, 2 Jan 2018 17:31:49 -0200
Message-ID: <CAOMZO5Dv1TO6QfiqjSwzgU8sdDHrtDqDkDESFFovscCtNMdCUg@mail.gmail.com>
References: <1514395632-15390-1-git-send-email-martin@kaiser.cx>
 <1514395632-15390-2-git-send-email-martin@kaiser.cx> <CAOMZO5AvFePCoKYQe7bt9bzFmdLYrgDyPLkepz99bJk7BTB0Lg@mail.gmail.com>
 <20180102161555.GA4503@botnar.kaiser.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102161555.GA4503@botnar.kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kaiser <martin@kaiser.cx>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sascha Hauer <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Martin,

On Tue, Jan 2, 2018 at 2:15 PM, Martin Kaiser <martin@kaiser.cx> wrote:

> Fabio, could you post the output of
>
> cat /sys/kernel/debug/suspend_stats
>
> after supend failed, to confirm that we're failing below
> device_suspend_noirq()?

Here it goes:

# cat /sys/kernel/debug/suspend_stats
success: 0
fail: 1
failed_freeze: 0
failed_prepare: 0
failed_suspend: 0
failed_suspend_late: 0
failed_suspend_noirq: 1
failed_resume: 0
failed_resume_early: 0
failed_resume_noirq: 0
failures:
  last_failed_dev:

  last_failed_errno:    -16
                        0
  last_failed_step:     suspend_noirq
