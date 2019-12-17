Return-Path: <SRS0=CLdZ=2H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF31C43603
	for <linux-serial@archiver.kernel.org>; Tue, 17 Dec 2019 15:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E31824655
	for <linux-serial@archiver.kernel.org>; Tue, 17 Dec 2019 15:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ErX7LsT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLQPuu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:50:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51794 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLQPuu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Dec 2019 10:50:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so3433996wmd.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Dec 2019 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O5GODPP3Q0p560cisTVf4hlzz8+PZk1HEIIOo83zKjI=;
        b=ErX7LsT8vWeRPPKk3e/Z8kRTGYWUXoAhcEUJAF+TLakDMZicAz+bfZHwoYWZaXr6/N
         fNMEBZ0HRRlN+sEWTbtmdTnagFEeRD21jNHrL9wqIcWu3ZSxR7k1+wzXHTmsiznMkw00
         lK2ymIZ/Ul39szT/nnwTotYIdOdM2FG1lYWKrv/1yPKRpnd2oealDZpZxaU26j18KQjW
         VqnOlYBF1Zu9wVTEf0AcTTaD6fwwvEn1meVNjceK8ZYbkd9ovczNaEv4CNYv+VPpwMz/
         NekKGCgVjX3WR1OOGPbjcQXuqP9GQoYfNZFzs+Dh7UUX1zyE/PWHWMDoQOCOSIMvNffd
         uIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O5GODPP3Q0p560cisTVf4hlzz8+PZk1HEIIOo83zKjI=;
        b=bT68KKS+gy4N8ZWVfE8ULGqk9Vi6XdcQRgzvRYcyWub7l7vUE0W43uTALX8+mEGB1X
         5MmxQQF8qgL4NRup9lrv4FL6Vr95C+g19HuoflZko4gLFyZEcmcBllycQ2E/4ZM3Thpi
         qyvbGb8Otx1b9IbnnIqsQEbfWZOoTCYxVWfcCk1937dv9cxU+3wwQVm3FFKBHD/+lH0P
         Sik4LYN0AXFK+3TtIDkmB8HRPkBcfmFKeBGJsoMiN6Yu/akAB+cwfuWbU4vup2K7YJcj
         vPKregyzYataG6Ouz0oVShvBwFX+h1F+6iJO7hsWmyZm6K9BjW9cA9awET+sOpgo2GuJ
         /PAA==
X-Gm-Message-State: APjAAAXOB5so+deoxhktcG2GvORYM33PfD3oKM2EgJOX6iNwzd7c3GKL
        AmlqfG+fj0lwBUzHVVGTPAeBfQ==
X-Google-Smtp-Source: APXvYqyL3KQslMZUtCZp1lc+/FSDTAieFKAidKYXOZf7uviRjTak0/OjQXad6Fp/k+j2otbFmfLJ+Q==
X-Received: by 2002:a7b:c1d8:: with SMTP id a24mr6329108wmj.130.1576597848708;
        Tue, 17 Dec 2019 07:50:48 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d16sm28132770wrg.27.2019.12.17.07.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:50:47 -0800 (PST)
Subject: Re: [PATCH 54/58] serial_core: Remove SUPPORT_SYSRQ ifdeffery
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-55-dima@arista.com>
 <20191217142732.GA3623513@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <71f8ea90-96cc-30f1-d13c-cd9c04276c68@arista.com>
Date:   Tue, 17 Dec 2019 15:50:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217142732.GA3623513@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/17/19 2:27 PM, Greg Kroah-Hartman wrote:
> On Fri, Dec 13, 2019 at 12:06:53AM +0000, Dmitry Safonov wrote:
>> No one defines it anymore.
>>
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  include/linux/serial_core.h | 14 ++++----------
>>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> I've applied this series up to here, skipping the usb-serial driver
> patch that Johan called out.
> 
> Can you rebase your series and resend the remaining based on my tty-next
> tree, after these patches move there (give them 24 hours to get through
> 0-day testing.)

Thanks much, Greg, will do!

Thanks,
          Dmitry
