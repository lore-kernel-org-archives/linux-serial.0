Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E263C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1215161103
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbhHMPFR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240928AbhHMPFQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 11:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49BAF61102;
        Fri, 13 Aug 2021 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628867089;
        bh=pCnFpMRtS+e2XhtLoiMVTHyFudGfKS2FuJvMqpXcFw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKYWEf7Bc6BzXV3M5PhO81/Cen+j65tX4Xw4T7Lx/J8BMn7EkyYM/44t1jUP2HQye
         FUqgZjC1m19cxTlKIzkkZ49cpxT3yL7p02nVNEvi3eeqY9Q6sTBYf2WmD1Mna20LB7
         de5kDQm1L3EOgHYevA1BQE7oJnkJb9+GQ5UR1XXE=
Date:   Fri, 13 Aug 2021 17:04:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Bing Fan <hptsfb@gmail.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH v6] arm pl011 serial: support multi-irq request
Message-ID: <YRaKDxUq5fifGJ75@kroah.com>
References: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
 <YRYc9nCcpGOs4SaJ@kroah.com>
 <9c3a4336-b6c4-d96e-9a9d-8001dddcee20@gmail.com>
 <YRYqq5Cgqy3975e1@kroah.com>
 <f3d4ba49-0cf8-9e92-77c1-ea8964b4e6b9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3d4ba49-0cf8-9e92-77c1-ea8964b4e6b9@arm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Aug 13, 2021 at 03:08:48PM +0100, Robin Murphy wrote:
> Hi Greg,
> 
> On 2021-08-13 09:17, Greg KH wrote:
> > On Fri, Aug 13, 2021 at 03:56:01PM +0800, Bing Fan wrote:
> > > 
> > > 在 8/13/2021 15:19, Greg KH 写道:
> > > > On Fri, Aug 13, 2021 at 11:31:30AM +0800, Bing Fan wrote:
> > > > > From: Bing Fan <tombinfan@tencent.com>
> > > > > 
> > > > > In order to make pl011 work better, multiple interrupts are
> > > > > required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
> > > > > at the same time, pl011 to GIC does not merge the interrupt
> > > > > lines(each serial-interrupt corresponding to different GIC hardware
> > > > > interrupt), so need to enable and request multiple gic interrupt
> > > > > numbers in the driver.
> > > > > 
> > > > > Signed-off-by: Bing Fan <tombinfan@tencent.com>
> > > > > ---
> > > > >    drivers/tty/serial/amba-pl011.c | 39 +++++++++++++++++++++++++++++++--
> > > > >    1 file changed, 37 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > > > > index e14f3378b8a0..eaac3431459c 100644
> > > > > --- a/drivers/tty/serial/amba-pl011.c
> > > > > +++ b/drivers/tty/serial/amba-pl011.c
> > > > > @@ -1701,6 +1701,41 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
> > > > >    	}
> > > > >    }
> > > > > +static void pl011_release_multi_irqs(struct uart_amba_port *uap, unsigned int max_cnt)
> > > > > +{
> > > > > +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> > > > > +	int i;
> > > > > +
> > > > > +	for (i = 0; i < max_cnt; i++)
> > > > > +		if (amba_dev->irq[i])
> > > > > +			free_irq(amba_dev->irq[i], uap);
> > > > > +}
> > > > > +
> > > > > +static int pl011_allocate_multi_irqs(struct uart_amba_port *uap)
> > > > > +{
> > > > > +	int ret = 0;
> > > > > +	int i;
> > > > > +	unsigned int virq;
> > > > > +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> > > > > +
> > > > > +	pl011_write(uap->im, uap, REG_IMSC);
> > > > > +
> > > > > +	for (i = 0; i < AMBA_NR_IRQS; i++) {
> > > > > +		virq = amba_dev->irq[i];
> > > > > +		if (virq == 0)
> > > > > +			break;
> > > > > +
> > > > > +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
> > > > > +		if (ret) {
> > > > > +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
> > > > > +			pl011_release_multi_irqs(uap, i - 1);
> > > > > +			break;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > This function looks identical to pl011_allocate_irq(), so what is the
> > > > difference here?  Why is this still needed at all?  What does it do that
> > > > is different from pl011_allocate_irq()?
> > > 
> > > The v6-patch is based on master of
> > > git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git, not tty-next.
> > 
> > Always submit patches based on tty-next if you want them accepted into
> > that tree.
> > 
> > > As below, the pl011_allocate_irq function supports single irq request only,
> > > which different from pl011_allocate_multi_irqs.
> > > 
> > > static int pl011_allocate_irq(struct uart_amba_port *uap)
> > > {
> > >      pl011_write(uap->im, uap, REG_IMSC);
> > > 
> > >      return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011",
> > > uap);
> > > }
> > 
> > Ok, but that does not reflect what is in my tree to be merged for
> > 5.15-rc1.  What is wrong with the code in there that is incorrect and
> > needs to be changed?
> 
> As reported by Qian Cai, it blows up on ACPI-based systems by assuming
> port.dev is an amba_device when in fact in that situation it's a
> platform_device. If you're able to drop the current patch from your tree
> that would probably be the best thing to do for the moment.

I have not seen any such bug report.

If something needs to be reverted in linux-next, (i.e. in my tty-next
branch), please let me know.  Ideally by sending a pathc to do so...

thanks,

greg k-h
