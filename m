Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2248DC433ED
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 13:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D021B61435
	for <linux-serial@archiver.kernel.org>; Thu, 22 Apr 2021 13:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhDVNPs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Apr 2021 09:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVNPs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Apr 2021 09:15:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16E9261426;
        Thu, 22 Apr 2021 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619097313;
        bh=qYbinlozbiPMkWqTzsC8oiOShV5c2Xd4JeYWmDaKed4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDsdJBagcHSbWpTjPwuiLei0YCvMarWaL7fAepN/1GASOs2Zj56wgx7Ogk8EfXlwo
         TW94TS+Q9iO86l9hnZ5aPlFBa4/2XkrQtVhOCIex57/1xAXeA60IKo1FDqfktSk3HG
         jJjH84uHWWe6iDEmMTMlgCuHgcxjORT0EMdOcUlel45yCUARSpCSwO1poNcENrK6Vp
         78ixzp1+vPzxQ6DxGfauV/SIirULq8s9fbKCv//4+AGM0RdNzelP0m6qgnwppA4pxL
         yGC8uZerTWRQ7nr5WIQFHlvF7/1DrngxzX/dqCS/YrpLo8TboyPVn1rc/4WtONSJyA
         tGt5NmLyWAHnQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZZAs-0008SM-8K; Thu, 22 Apr 2021 15:15:18 +0200
Date:   Thu, 22 Apr 2021 15:15:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tty: serial: jsm: remove redundant assignments of
 several variables
Message-ID: <YIF25kxW99LfysdQ@hovoldconsulting.com>
References: <20210422121115.246625-1-colin.king@canonical.com>
 <YIFxfH4MXc1ekn4f@hovoldconsulting.com>
 <c9497e47-cdfb-7be0-ad35-648ea5d68268@canonical.com>
 <YIFydeoE/WRfPcvA@hovoldconsulting.com>
 <0b9086b4-8da8-c18e-ad22-1f52d6ed0686@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b9086b4-8da8-c18e-ad22-1f52d6ed0686@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 22, 2021 at 02:01:36PM +0100, Colin Ian King wrote:
> On 22/04/2021 13:56, Johan Hovold wrote:
> > On Thu, Apr 22, 2021 at 01:53:03PM +0100, Colin Ian King wrote:
> >> On 22/04/2021 13:52, Johan Hovold wrote:
> >>> On Thu, Apr 22, 2021 at 01:11:15PM +0100, Colin King wrote:
> >>>> From: Colin Ian King <colin.king@canonical.com>
> >>>>
> >>>> Several variables are being assigned with values that are never
> >>>> read and being updated later with a new value. The initializations
> >>>> are redundant and can be removed.
> >>>>
> >>>> Addresses-Coverity: ("Unused value")
> >>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >>>> ---
> >>>>  drivers/tty/serial/jsm/jsm_cls.c | 6 ++----
> >>>>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
> >>>> index b507a2cec926..b58ea4344aaf 100644
> >>>> --- a/drivers/tty/serial/jsm/jsm_cls.c
> >>>> +++ b/drivers/tty/serial/jsm/jsm_cls.c
> >>>> @@ -349,8 +349,8 @@ static void cls_assert_modem_signals(struct jsm_channel *ch)
> >>>>  
> >>>>  static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
> >>>>  {
> >>>> -	int qleft = 0;
> >>>> -	u8 linestatus = 0;
> >>>> +	int qleft;
> >>>> +	u8 linestatus;
> >>>>  	u8 error_mask = 0;
> >>>>  	u16 head;
> >>>>  	u16 tail;
> >>>> @@ -365,8 +365,6 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
> >>>>  	head = ch->ch_r_head & RQUEUEMASK;
> >>>>  	tail = ch->ch_r_tail & RQUEUEMASK;
> >>>>  
> >>>> -	/* Get our cached LSR */
> >>>> -	linestatus = ch->ch_cached_lsr;
> >>>>  	ch->ch_cached_lsr = 0;
> >>>
> >>> Why leave this assignment in? Looks like this was all copy-pasta, but
> >>> this assignment makes even less sense now that you remove the comment
> >>> and load.
> >>
> >> Which assignment are you referring to?
> > 
> > The one just above my comment: 
> > 
> > 	ch->ch_cached_lsr = 0;
> 
> that cached value is being used in jsm_neo.c, so removing the zero'ing
> may cause some issues.

That's for you to determine, right? Only doing half of a clean may
actually be worse than doing nothing at all. At least now it's somewhat
clear why that statement is there.

The jsm_neo.c implements support for a different class of devices and
only those actually use ch_cached_lsr AFAICT.

It would be good if you include some context in the commit message such
as which commit added this code and that it has never been used.

Johan
