From: Robin Gong <b38343@freescale.com>
Subject: Re: [PATCH v1] Revert "serial: imx: remove unbalanced clk_prepare"
Date: Wed, 4 Nov 2015 15:53:49 +0800
Message-ID: <20151104075346.GA10809@shlinux2>
References: <1446605898-27635-1-git-send-email-b38343@freescale.com>
 <CAOMZO5AsUMJsfYanz0RGQ-V=ZM5X9a7GeVEUHOB0tmySqV_v2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5AsUMJsfYanz0RGQ-V=ZM5X9a7GeVEUHOB0tmySqV_v2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eduardo Valentin <edubezval@gmail.com>, "fugang.duan@freescale.com" <fugang.duan@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 04, 2015 at 01:39:17AM -0200, Fabio Estevam wrote:
> On Wed, Nov 4, 2015 at 12:58 AM, Robin Gong <b38343@freescale.com> wrote:
> > commit 9e7b399d6528 ("serial: imx: remove unbalanced clk_prepare").
> > Otherwise below warning happen since there are some printk logs in
> > interrupt.
> 
> This has already been reverted since v4.3-rc5.
That's great, please ignore this patch.
