Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D67C3DA7A
	for <linux-serial@archiver.kernel.org>; Thu,  5 Jan 2023 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbjAEUrl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Jan 2023 15:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjAEUrk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Jan 2023 15:47:40 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D23AE63
        for <linux-serial@vger.kernel.org>; Thu,  5 Jan 2023 12:47:38 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A7E0D855ED;
        Thu,  5 Jan 2023 21:47:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1672951657;
        bh=YzeimdHMWt2nVwx8dFppUVXQs6aJ/fy+Q8hLm/F25n4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jEEEb2ubfo2YJ6GeqPXd0n2zh2uZAP2rTol74337eMsUsVfo3Xmn0MKWGC8Pr6N7e
         V0GPIGzgVTZO1z+SWGbnM4wOAzO2JF/mEXc9GeRZRrGnaS9JcIxjCn1KKhC/YFWsYY
         +IE2vWfAxOah0Cy5aCucsi4QpuGHcMc2PsFG/eCkIaB2VSIgcFaaMi1ljCF/T6fTov
         cOh+n1ZBIfrSDGEX7vjnFwmWUoaeytEf/TZmy8DEfVuAlVsof5X88AcPXgpBDM4hsn
         IgdL/sGfU8nmU+k15SV77V6voGpgaUmKLxyJFJY3N0UBCM8HfnsAzpkDH2sMb9yr7D
         q/15I1Zoh6w9w==
Message-ID: <212119f9-d59f-76f2-18b7-d6248767ea4a@denx.de>
Date:   Thu, 5 Jan 2023 21:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] serial: stm32: Merge hard IRQ and threaded IRQ
 handling into single IRQ handler
Content-Language: en-US
To:     Valentin CARON <valentin.caron@foss.st.com>
Cc:     linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221216115338.7150-1-marex@denx.de>
 <b4e13643-0494-329a-2d41-06da985b9dfe@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <b4e13643-0494-329a-2d41-06da985b9dfe@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 1/5/23 15:56, Valentin CARON wrote:
> Hi Marek,

Hello Valentin,

> It is OK for me.
> 
> Tested-by: Valentin Caron <valentin.caron@foss.st.com>

Thank you. I might need one more test for V4 in a bit.
