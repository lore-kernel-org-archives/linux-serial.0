Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B6EC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 06:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201E460FD9
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 06:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhDZG5W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 02:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhDZG5V (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 02:57:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E530961075;
        Mon, 26 Apr 2021 06:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619420199;
        bh=FRdhoAdxm6/19IneKgn0hKbmEd783utXsEPDXU8ff28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBJNd7wS4MXiEJTHCV+a8O3ZholJDx6OoiGaJlfXRK/5z8XCpg7pp8qE0s+p+7+rC
         5T/6bEQpoiiSDcx/ZqLS/Eqs8ifn05Ki3xBwZakfTlqH53GZy30vU9OHZtJhDxzMvo
         g73yfUFWjWJ7kz3YAIkJ7kppz8VQ18bCsy+dLg7I=
Date:   Mon, 26 Apr 2021 08:56:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     "tiantao (H)" <tiantao6@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>, jirislaby@kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: samsung_tty: remove set but not used
 variables
Message-ID: <YIZkJUel4RPs4lMf@kroah.com>
References: <1619170740-63717-1-git-send-email-tiantao6@hisilicon.com>
 <YIKXs7WCF2zI3uvI@kroah.com>
 <660e8905-6c5c-e076-5211-a87a62ea5c87@huawei.com>
 <YIKeAFbqyl00tHXH@kroah.com>
 <6ea876c3-2ffb-ed39-e927-0eea57af21bd@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ea876c3-2ffb-ed39-e927-0eea57af21bd@canonical.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 08:45:44AM +0200, Krzysztof Kozlowski wrote:
> On 23/04/2021 12:14, Greg KH wrote:
> > On Fri, Apr 23, 2021 at 05:54:16PM +0800, tiantao (H) wrote:
> >>
> >> 在 2021/4/23 17:47, Greg KH 写道:
> >>> On Fri, Apr 23, 2021 at 05:39:00PM +0800, Tian Tao wrote:
> >>>> The value of 'ret' is not used, so just delete it.
> 
> Tian Tao, please use scripts/get_maintainers.pl to get the list of
> people needed for Cc.
> 
> >>>>
> >>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> >>>> ---
> >>>>   drivers/tty/serial/samsung_tty.c | 1 -
> >>>>   1 file changed, 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> >>>> index d9e4b67..d269d75 100644
> >>>> --- a/drivers/tty/serial/samsung_tty.c
> >>>> +++ b/drivers/tty/serial/samsung_tty.c
> >>>> @@ -2220,7 +2220,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
> >>>>   			default:
> >>>>   				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> >>>>   						prop);
> >>>> -				ret = -EINVAL;
> >>> That looks odd, shouldn't you do something with this instead of ignoring
> >>> it???
> >>
> >> How about this ？
> >>
> >> diff --git a/drivers/tty/serial/samsung_tty.c
> >> b/drivers/tty/serial/samsung_tty.c
> >> index d9e4b67..9fbc611 100644
> >> --- a/drivers/tty/serial/samsung_tty.c
> >> +++ b/drivers/tty/serial/samsung_tty.c
> >> @@ -2220,8 +2220,7 @@ static int s3c24xx_serial_probe(struct platform_device
> >> *pdev)
> >>                         default:
> >>                                 dev_warn(&pdev->dev, "unsupported
> >> reg-io-width (%d)\n",
> >>                                                 prop);
> >> -                               ret = -EINVAL;
> >> -                               break;
> >> +                               return -EINVAL;
> >>
> > 
> > You tell me, does the patch work for you?
> > 
> > Is this really a "hard error" and did you now just break devices that
> > used to work properly?  Are you correctly unwinding any previously
> > allocated state when you return here?
> > 
> > Please do some research on this, and ideally, lots of testing, before
> > submitting it as a real solution.
> 
> It's a patch coming from automated tool (e.g. Coverity), so I doubt
> there is any testing here. However the "return -EINVAL" looks correct here:
> 1. No particular unwinding is needed here,
> 2. It's an optional property (not used by existing DTS, only
> non-upstreamed by Samsung) thus treating it as hard-error is fine.
> Probably better to exit than convert it to some default value.

So is that a "Reviwed-by:" or not?  :)

