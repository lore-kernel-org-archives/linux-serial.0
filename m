Return-Path: <SRS0=20mg=6P=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A08C47253
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDD0208CA
	for <linux-serial@archiver.kernel.org>; Fri,  1 May 2020 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf4z3HGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgEALsp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 May 2020 07:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728575AbgEALsp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 May 2020 07:48:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC885C061A0C;
        Fri,  1 May 2020 04:48:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so2396614ljd.3;
        Fri, 01 May 2020 04:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dig23RuRs189LdUum62TrNfBwCZg16Ct3kOkDao4T0s=;
        b=Sf4z3HGyNgtaUDgQdmV4w7ppiVAD2yApc+2f9DshZTgeeHrXWs3GIl5v2JZMMdTneJ
         UkKGKv1uBzbPWEaua/VyDRgfiQl0hhxx6pJzgtDZRCiEj+3rnr/mFTogG+IxuGaXR0xs
         NS1w+5UJuaUac65Ie6qFs6oJIQ0S55SK+UKiHt+p0RLrSZjmmmeit7ALgu+Mbv/5/PAl
         6cGNtly/IIRJmpAyArs4juRFZom/0mUfUYpG+LPIpJh0qndu1yY5NgtBhEyAmp90LR4E
         PQgGli3fJrzDqpVHL3sc8vM+tGrVA6X7qk1Sq0dLWPEcN7/MO4aDBelvs5sIflmIWKcT
         ZVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dig23RuRs189LdUum62TrNfBwCZg16Ct3kOkDao4T0s=;
        b=f0nsReVX0ZnX2smHQd6dZ1SrRwdEDA5zAqQ62w2woX+sBs1hf+z4BDsupmIhbCxn0n
         4nVtfbdaMCZk1HgAZHSDz/nsLlQds2u5gPctPnd5RqZy+ou6CspdjHp8NSVyebSBzxpo
         FN06LMXN1hyp8qtmCleUGm5dcuI3b/tk6W50ZFGSHHiIdkjH1uG0qOZluIq1DEgMLoxO
         rYA+zq3nDdH1rhXAivOSDJUxKVXSbIKC+A15v4AyPsUPcC8QiQx1V5076fNzT4P+S82e
         b68PfED1TekGL96bKcjcEsLajcGyXnP0LltPxFEnOJVoDGrCrDuR34q5SSaP6a8kT95j
         MwJA==
X-Gm-Message-State: AGi0PuZBqSPkseEmAOlOxmtIpQ0L9QuVu0f379AwqTk42TpDwiLW8DXa
        8rk/oxUGrHwBBACPHEoQ3Ss=
X-Google-Smtp-Source: APiQypIWbdKP3x5oc5BQj1xS00WNTozEO+AuxkfFnYcJu3dZqHObbFTxNVNKA+3oP/IeUHNQRjeSwQ==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr2259265ljh.65.1588333722221;
        Fri, 01 May 2020 04:48:42 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id g19sm2023579lfb.30.2020.05.01.04.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 04:48:41 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/3] printk: Add function to set console to
 preferred console's driver
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Feng Tang <feng.tang@intel.com>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
 <20200430161438.17640-2-alpernebiyasak@gmail.com>
 <20200501014454.GB288759@jagdpanzerIV.localdomain>
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Message-ID: <b1b5514e-936e-a5e4-3dd6-3e640a819ffc@gmail.com>
Date:   Fri, 1 May 2020 14:48:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501014454.GB288759@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 01/05/2020 04:44, Sergey Senozhatsky wrote:
> Hmm. Preferred console selection is very fragile, there are too many
> setups and workarounds that even minor tweaks introduce regressions
> oftentimes.

All this would only execute on #ifdef VT_CONSOLE right now and I think
they can be gated further by a new Kconfig like VT_CONSOLE_PREFERRED, if
that'd make it better.

> We have, by the way, a pending patchset which changes the same
> are - preferred console selection.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-5.7-preferred-console

I was working on next-20200430 where that patchset is already included,
can confirm it doesn't solve this problem. I hope I've correctly avoided
breaking it by setting its "has_preferred_console" variable (thus this
patchset somewhat depends on that).

> Let me take a look over the weekend.

Thanks in advance.
