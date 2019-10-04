Return-Path: <SRS0=XuIp=X5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB88C4CED1
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0395920700
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 14:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsAZndhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbfJDOhX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:37:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39460 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389100AbfJDOhX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Oct 2019 10:37:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so6130457wml.4
        for <linux-serial@vger.kernel.org>; Fri, 04 Oct 2019 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M/bUMMwqhNt3Ns3PLD9fJksR9IwlrBLW7LrP5HWQF+c=;
        b=FsAZndhBRWOshUk2HtpFWBNhf8XA3iFaT+XxTApJiTi4sWWDA8mEi4lEWRyTonYxLE
         ZydU83dqlBb8DOGRZ22Vay1pRKjZ4Q54J3PwVxVrEm5b22dhcyv+niYmuPHtnpPA+gtF
         Ne3c/iFvOSgGU4NrDjQM2qM4RqbJWDijBpfuM6Irnohrlp5mf+h6XHoAkq7RB/bH06jG
         YVkfy/4F+0esR4D1tsBSWe3OI+GV/pvuOQf8JYjyDLCkrZqjuSQOqUCrqtbqS6hl29kf
         IL35Xa2IkpfLN6XzneIEOQCivUmEthM3mZQ4KH2A9fJ7srdvawl557EFAr/n1HJRYmsD
         NbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M/bUMMwqhNt3Ns3PLD9fJksR9IwlrBLW7LrP5HWQF+c=;
        b=JolXiaPczLc+ivGqv/Q8BkP5BynVIH2wHYA7aSRyMGGN3uDy94DMipcgQiLcqDO3yg
         NxM9wgR5NYiwAvzIKNQ6GIcyNDAKYUAXZtEX/yLuNZNdWtrgZahhkqhF6fIp2RJLNF6m
         Pl6z50Nc3Atk9gLkML8H5M1441S8hqh1QxwHGIXAD+XImnN3gRoPmxpI9Cmi7Hex7yq8
         JoYo6uPM/kIocncPJ8qzt3POxfD2dYf5WQK8BT3rGsLOragFAYWg8W9QsB9AMHDqgnh4
         5m+SJIsyG0rD6DOtD8DgFXC+4a2Ybom+D8OsvGMGti6DKYeEJ/NPWwmorc92mvwuzfde
         iQ5Q==
X-Gm-Message-State: APjAAAXaGZ+DYZjQz+HGGdtHWC9VcVxjfJ607l8rBcFU5GLslLhOwuQl
        ZOl+MwT9ySRHI+ZjfgA5rSRV9g==
X-Google-Smtp-Source: APXvYqxHRyx7yuiTH9IFzXeP2ivnk2BBRSV88nnMFiXyc7Dc5BayI1lrnlB/z2mqvBmn5UbH1qOKKw==
X-Received: by 2002:a1c:5942:: with SMTP id n63mr11413363wmb.65.1570199841070;
        Fri, 04 Oct 2019 07:37:21 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id u25sm5195823wml.4.2019.10.04.07.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 07:37:20 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:37:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Thomas Bogendoerfer <tbogendoerfer@suse.de>, kbuild-all@01.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 3/4] mfd: ioc3: Add driver for SGI IOC3 chip
Message-ID: <20191004143718.GM18429@dell>
References: <20190923114636.6748-4-tbogendoerfer@suse.de>
 <201909232145.eyOJqt2k%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201909232145.eyOJqt2k%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Message-ID: <20191004143718.p15UsOTXF41HI-CJ-NHtCjpqR7MhR2VLhXxLSOgta64@z>

On Mon, 23 Sep 2019, kbuild test robot wrote:

> Hi Thomas,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [cannot apply to v5.3 next-20190920]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Thomas-Bogendoerfer/Use-MFD-framework-for-SGI-IOC3-drivers/20190923-194903
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers//mfd/ioc3.c: In function 'ioc3_eth_setup':
> >> drivers//mfd/ioc3.c:281:54: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
>        sizeof(ioc3_w1_platform_data.dev_id), "ioc3-%012llx",
>                                                    ~~~~~~^
>                                                    %012x
>        ipd->pdev->resource->start);
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~                         

I assume you plan on fixing this Thomas?


-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
