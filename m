Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4191C433B4
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 08:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A172561153
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 08:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhDPIvf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240223AbhDPIve (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Apr 2021 04:51:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B17B061107;
        Fri, 16 Apr 2021 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618563069;
        bh=G20fHV8vaPYOZuC6bTk72/oUnsXRu84bnbsf13JZmRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GnF3XUS3RhH9h9JHdtddbI5eZLxqQMnxkdnEvZx6UGHHsi8TJ81OQojgjmBIzQCEu
         1TQZmcXPt4V1rax7BxmPJVQDGB/9QtUQIxk8BhOgNfPs1SGCrIhTjnU9Oix9A7OWZO
         6Y06OecRcy1jyn3/DKFbxzbsxt6Cd/SijD1TCEFm2qkBplV+y1q+F6VGz7XXnF8gYE
         bbyMEk0Je6cYdc7z7G+jUZzIZgjFB4vqX8IoO2MAaRXOjSWJnQI7mm7rCF3yXdwknV
         Mg7zeIl0Ly6oVKzAP1FT3JNE7XBb7NXJCyCORqVds3wXizvG4IXpZtmHXbR9ORpTnF
         7Wc84BwRSOCTA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lXKBx-0001M3-Dk; Fri, 16 Apr 2021 10:51:09 +0200
Date:   Fri, 16 Apr 2021 10:51:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Erwan LE RAY <erwan.leray@foss.st.com>
Cc:     dillon min <dillon.minfei@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Gerald Baeza <gerald.baeza@foss.st.com>
Subject: Re: [PATCH v2] serial: stm32: optimize spin lock usage
Message-ID: <YHlP/SryZXr/nNLM@hovoldconsulting.com>
References: <1618219898-4600-1-git-send-email-dillon.minfei@gmail.com>
 <YHRGPpQ03XgBMkiy@hovoldconsulting.com>
 <CAL9mu0JF-9hy3Z_ytpEO+hzKh0D+f-0gYaUBEA0v28EOHpC80w@mail.gmail.com>
 <CAL9mu0Ke97FUZ03jvdH8Lz2qRnVY82B7tAEtjbhW97sPOVkAxQ@mail.gmail.com>
 <e17fddfb-f9b8-238f-da74-a4746f33134f@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17fddfb-f9b8-238f-da74-a4746f33134f@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[ Please avoid top-posting. ]

On Thu, Apr 15, 2021 at 07:09:14PM +0200, Erwan LE RAY wrote:
> Hi Dillon,
> 
> STM32MP151 is mono-core, but both STM32MP153 and STM32MP157 are 
> dual-core (see 
> https://www.st.com/content/st_com/en/products/microcontrollers-microprocessors/stm32-arm-cortex-mpus.html).
> So your point is fully relevant, thanks.
> 
> ST already fixed the same issue in st-asc.c driver in the past (see 
> ef49ffd8), because a systematic deadlock was detected with RT kernel.

That's not the same issue. The above mentioned commit fixed an issue on
*RT* where local_irq_save() should be avoided.

> You proposed a first implementation in your patch, and a second one in 
> the discussion. It seems that your initial proposal (ie your V2 patch) 
> is the most standard one (implemented in 6 drivers). The second 
> implementation is implemented by only 1 company.
> 
> It looks that the solution is to avoid locking in the sysrq case and 
> trylock in the oops_in_progress case (see detailed analysis in 
> 677fe555cbfb1).
>
> So your initial patch looks to the right proposal, but it would be safer 
> if Greg could confirm it.

That would only fix the RT issue (and by making the sysrq one slightly
worse).

Using uart_unlock_and_check_sysrq() would address both issues.

Johan
