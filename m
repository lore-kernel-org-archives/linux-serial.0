Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B131C46467
	for <linux-serial@archiver.kernel.org>; Wed, 11 Jan 2023 05:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjAKFzN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Jan 2023 00:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjAKFzK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Jan 2023 00:55:10 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6FB1E9;
        Tue, 10 Jan 2023 21:55:05 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso1849394wmb.1;
        Tue, 10 Jan 2023 21:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRQ7HHnQjET8OELyMhM+xyLIeM+NZD0Sq7OKqMBy2gc=;
        b=HvKNouhN9wfXBKEiiqWZezsRPm/2/REd79foMQ33kl1Oqfdvq60A5NiyfJOMzJXDnb
         HBZMv41GKa5HQCxWWLrZquky6C5EoXrZEhmlLL0Cb6mBECn2jgMqJXriGcxavYKASLgp
         lPkgizXn7VEwqVzzsTeegcOxnYJx6Lz1N29KLekjS95mym8+VT7MGcCRfv9ZYUuDUFOP
         u7npj5K5/Isiyz8v+6dG43I+B6atjWIyGmjJlB0dxGJNRVke0/p7LCmD6TSQHV0kEI8V
         u1VjPgPzLFU0pmg/DUHI/xjunZEkLWTVjaLwjQHztGviVLiGYM4gZ+0/aAV8OXTN10Gw
         DSTA==
X-Gm-Message-State: AFqh2koo18D+cGIMuzC9RJKSK0E6C64aWgekBMDRSGpoH7bbL1b+/lk/
        ND9dhSeQU62A+clzBo+uE0c=
X-Google-Smtp-Source: AMrXdXtoOoSZSJ5BMYPXoZtNrFVYde4X64oPZjMrc1nXfVSBE2sit3MYHLlqt45HxCYvEsSxKeV9IA==
X-Received: by 2002:a05:600c:a51:b0:3d2:3376:6f38 with SMTP id c17-20020a05600c0a5100b003d233766f38mr50206563wmq.20.1673416503620;
        Tue, 10 Jan 2023 21:55:03 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm23131175wmo.24.2023.01.10.21.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 21:55:03 -0800 (PST)
Message-ID: <3ce50f11-6f64-08ff-f5e6-5a14172b548d@kernel.org>
Date:   Wed, 11 Jan 2023 06:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 10/13] tty: Return bool from tty_termios_hw_change()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
 <20230110120226.14972-11-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230110120226.14972-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10. 01. 23, 13:02, Ilpo Järvinen wrote:
> Change tty_termios_hw_change() to return bool.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


-- 
js
suse labs

