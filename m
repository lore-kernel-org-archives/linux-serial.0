Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD28C41513
	for <linux-serial@archiver.kernel.org>; Fri,  4 Aug 2023 02:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjHDCCZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjHDCCX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 22:02:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA5448B
        for <linux-serial@vger.kernel.org>; Thu,  3 Aug 2023 19:02:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686f74a8992so269694b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 03 Aug 2023 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691114542; x=1691719342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLAyHP6q7d4xyqH5BrZ0J2y9ZHEmKn11Ag5iLKGIobk=;
        b=wP2ZuHLlNuDfTT71uzyzf0CV4FW0+5rHmVIqE6GOMVjwL3ZpUnT2g2DTt/WDPPdjrF
         2U2HC6n0rUbzNslkkp6Hn7rJWDpqfSmq9b66hXnpWCUj8YqrgFcHUJhG77/tAs47G266
         ElZhOuyclpDWX2rOoNKzHHzbVTAE54S07RIJ8OKTFKzcSexf0Gz621jhyP7rRN33bbXa
         tkJbJPIcYWZ4ZpCxxkdHqHPkTvp2YIFjPQGCcymM3t8fqWtXNJ1CJG5w9R5HSfJH6nCk
         KdkWaHmwZ/oMmmFXNOSYXCV4ARohZ/th4bdIj0Kq+d27AG7CIKhmk7x2SgAnQa4lZa+v
         ZR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691114542; x=1691719342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLAyHP6q7d4xyqH5BrZ0J2y9ZHEmKn11Ag5iLKGIobk=;
        b=TunFsH6qANu1R5qU5fJYWMy4xZD/fQv+8H68xPsa+WVZWIi7hLzzTdqDOKRsNKHAnu
         l4f63cOAB+zQiav3j/pMqI0lxOr5+oMhG5fkbRr+r9r0qJ7Aesu12CvNeJD6B2WWpRUh
         1w9Y4Yof9r+ghyJ0rmNBnJ1rdELddPxPGds/GxTVpM0YS3b0eWSOCNs0GSJQ9DwyM602
         i10B4DuTt0Ol9/UFMuqyQ2u6OvX74sQT+9qByRI0HkZTozhcIHbWmutmS8zRjzdwf5q/
         Vic5yri6VDPiVq6St6r2CjRhBPXtOe2cADhzQSPYR40UfWfgLaV7kN9moZP615bynIKU
         vf4A==
X-Gm-Message-State: ABy/qLbPdIl8zVhzyKcFEkkkUzfiIwFRJLy+qnb7UVximu1yQAQFNU0E
        czqwCPRgdmrBd2xL/dU0FrxPVA==
X-Google-Smtp-Source: APBJJlHGxvq+YAD+sdIdRb+NwnMfx8vt2DdNH34XqanHP+MVvvdnK8URPIL1n0IT/Nu8x7TU0I+uaA==
X-Received: by 2002:a05:6a00:8016:b0:675:8627:a291 with SMTP id eg22-20020a056a00801600b006758627a291mr20382970pfb.3.1691114542072;
        Thu, 03 Aug 2023 19:02:22 -0700 (PDT)
Received: from [172.20.1.218] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b006871dad3e74sm471163pfn.65.2023.08.03.19.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 19:02:21 -0700 (PDT)
Message-ID: <5dbc41bb-f843-dcd9-37d6-cf1f37cb80d4@kernel.dk>
Date:   Thu, 3 Aug 2023 20:02:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [linux-next:master] BUILD REGRESSION
 fb4327106e5250ee360d0d8b056c1eef7eeb9a98
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <202308040141.gUjtZ32J-lkp@intel.com>
 <ZMwH1WuEb1JEtZ4o@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZMwH1WuEb1JEtZ4o@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/3/23 2:02?PM, Matthew Wilcox wrote:
> On Fri, Aug 04, 2023 at 01:34:01AM +0800, kernel test robot wrote:
>> arm-linux-gnueabi-ld: storage.c:(.text+0x27c): undefined reference to `__brelse'
>> arm-linux-gnueabi-ld: storage.c:(.text+0x9c): undefined reference to `__bread_gfp'
>> storage.c:(.text+0x22c): undefined reference to `__bread_gfp'
>> storage.c:(.text+0x64): undefined reference to `__brelse'
> 
> I think something like this would fix it.  Jens?  Christoph?

Yep, someone else sent one earlier today, but looks like they didn't CC
the list. In any case, I replied with it CC'ed and got it applied.

-- 
Jens Axboe

