Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B01C0015E
	for <linux-serial@archiver.kernel.org>; Thu, 13 Jul 2023 13:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjGMNUJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Jul 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjGMNTz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Jul 2023 09:19:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05C142722;
        Thu, 13 Jul 2023 06:19:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9F061570;
        Thu, 13 Jul 2023 06:19:44 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B6B43F73F;
        Thu, 13 Jul 2023 06:19:01 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:18:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] serial: mps2-uart: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230713131858.l2lssuzkieicivm4@bogus>
References: <20230712062853.11007-1-frank.li@vivo.com>
 <20230712062853.11007-9-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712062853.11007-9-frank.li@vivo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 12, 2023 at 02:28:47PM +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
