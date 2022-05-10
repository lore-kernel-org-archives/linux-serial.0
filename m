Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A620CC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 10 May 2022 12:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiEJMue (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 May 2022 08:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiEJMud (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 May 2022 08:50:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A909E5293;
        Tue, 10 May 2022 05:46:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6EB751F4198D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652186792;
        bh=+xFxCucJWWtb43xJt9JV4bBlZQLYnNsYtFFdf0v6JvY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EWr7A6fCbxjvxIJmYEHOty2p7MGW8MXul4Z71n2qRmh7shjPIeTr1QiTlAVeSTput
         SCHAkqjlcgTyc5T5FJm26xhwF+Ry1vMfuSVOSPPHlGIbcohBujXjWKPZkfr/pRF2f0
         109zi5LipeG8ydMHHubYVvjqbdQEAO1uwEwHBr5uXcd9+r66zJkFvRXF6bSbMa9BlU
         s/fZfCly2sAs4XqC1+m/6gNLkDsW5uwZVK/a+9mKqHd6jc1iFneI/9fyUuRqPGvv/s
         3PmpoCSf1oVqcvoDbdx5DCsaK3XU4/FOESIPy884NcvG7lxk6kRLb//GEn4dcTnuYX
         1XccN83PA8geQ==
Message-ID: <b13b019f-f766-60df-3764-d375f64ea7d3@collabora.com>
Date:   Tue, 10 May 2022 14:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right
 FEATURE_SEL"
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
References: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
 <YnpeYGbo7JJK0lDk@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YnpeYGbo7JJK0lDk@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Il 10/05/22 14:45, Mark Brown ha scritto:
> On Tue, May 10, 2022 at 02:26:20PM +0200, AngeloGioacchino Del Regno wrote:
>> It was found that some MediaTek SoCs are incompatible with this
>> change. Also, this register was mistakenly understood as it was
>> related to the 16550A register layout selection but, at least
>> on some IPs, if not all, it's related to something else unknown.
>>
>> This reverts commit 6f81fdded0d024c7d4084d434764f30bca1cd6b1.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>


Sorry for missing this tag, and also I'm sorry for the noise.

Regards,
Angelo
