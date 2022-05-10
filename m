Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A92C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 10 May 2022 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345896AbiEJPfI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 May 2022 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbiEJPee (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 May 2022 11:34:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C90BA997;
        Tue, 10 May 2022 08:29:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F34F21F424D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652196583;
        bh=uJRHaCeOEBQcOZ0I5YodDyMVQnV4u4MF2nMkQyoDrmg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b8jMcQgCtA/xqIWPX4KqwUbHiEE9vt7wnr/RsMKkR7UGTITO5Lb7eQC4g0FIndVoP
         /gDyg3b66kVa77mYqnjFbNWKhWp0QtsnCp7lW3N4h1dvwRrWGeDfrxy4Lx3gTX0xwp
         cQEhX1tqiHZtyHdMIMWY0iYfKUOBTOCwRh/re781GYdsQB0HMb5/sIdEwqFkV8Sy2L
         2nStvk0DaQEoXJaUcFu5sdxaMXH286Hh+Jdqxaf/evE3/WtS1tP4+h9FACEEvJbuok
         C/HcYwGTqC6C3JQIir1vk4K/xQ48bpETkXImRkvKLC/jbrhHSUtO5Ga3WNRrnhDkjB
         GFDwJp+nDwB4w==
Message-ID: <63169e65-cbfa-d495-754f-023dc8befa42@collabora.com>
Date:   Tue, 10 May 2022 17:29:40 +0200
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
 <b13b019f-f766-60df-3764-d375f64ea7d3@collabora.com>
 <YnphFjs4E4EYafT4@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YnphFjs4E4EYafT4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Il 10/05/22 14:56, Mark Brown ha scritto:
> On Tue, May 10, 2022 at 02:46:28PM +0200, AngeloGioacchino Del Regno wrote:
> 
>> Sorry for missing this tag, and also I'm sorry for the noise.
> 
> Hey, if nobody broke anything all this testing stuff wouldn't be worth
> it!


Haha! That's true :-)

Thank you!
