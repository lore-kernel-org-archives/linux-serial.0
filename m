Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D8CC43334
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 12:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiFFMau (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiFFMat (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 08:30:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBAA2A3A23;
        Mon,  6 Jun 2022 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654518648; x=1686054648;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XbjNlt3CgxlWJwI2YJzT7T5pyVzwTRcy1dlaQHnhbo4=;
  b=JMFxfA4mnwPgl7BFrbjwfjhLRSGe7FsIvmUN65m0ldJB12laIcFuE/cs
   MSC70lHd6fGnE2ysHFo9Wq1O8zjiUwcy5IjOqvidHi04xgXMziqhTe7c2
   uiexSh6yYFgEjedJUhTNsdaV2/Hkc0661rSCdg5+mm1tRo1C/wfe9EgSW
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 06 Jun 2022 05:30:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 05:30:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 05:30:45 -0700
Received: from [10.242.7.200] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 05:30:42 -0700
Message-ID: <a7e8b822-a33d-ff50-e740-4884c44813e7@quicinc.com>
Date:   Mon, 6 Jun 2022 18:00:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Stephen Boyd" <swboyd@chromium.org>
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
 <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
 <CGME20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b@eucas1p1.samsung.com>
 <3866c083-0064-ac9a-4587-91a83946525d@samsung.com>
 <ff029402-f90c-096a-7366-b58f53555ace@quicinc.com>
 <fb44af37-daf7-974d-95fe-1a6c2cdab676@samsung.com>
 <cb802fb1-d0b8-68af-1c04-f73bc1beca77@quicinc.com>
 <f525c352-d995-0589-584f-0e9acf419f80@quicinc.com>
 <CAD=FV=UyNgfYe2Xh3uuYYHB4yPajZKO+i8nCngFn7TedbF-piA@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=UyNgfYe2Xh3uuYYHB4yPajZKO+i8nCngFn7TedbF-piA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,


On 6/4/2022 12:58 AM, Doug Anderson wrote:
> Hi,
>
> On Fri, Jun 3, 2022 at 11:54 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>>>>> Add a start_rx in uart_resume_port after call to set_termios to handle
>>>>> this scenario for other drivers.
>> Since start_rx is not exposed it doesn't seem like we will be able to
>> handle it in core.
>>
>> In your drivers, Can we add a call to stop_rx at begin of set_termios
>> and then undo it at end?
>>
>> That would ensure that set_termios functionality is unaffected while
>> fixing the broken cases?
>>
>> If that's not an option we will have to go back to a previous version of
>> limiting the change to qcom driver.
> How about this: add an optional start_rx() callback to "struct
> uart_ops" and then only do your stop_rx() logic in uart_suspend_port()
> if you'll be able to start it again (AKA if the start_rx() callback is
> not NULL). That keeps the logic in the core.

This seems good. Thank you.

And also conditionally call start_rx in uart_resume_port after call to 
set_termios?
I have tested such patch and it is working fine, will upload it.

-Vijay/

> -Doug
