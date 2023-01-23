Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77DCC05027
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 15:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjAWPRm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjAWPR0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 10:17:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539812B0A7
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:16:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k16so9280805wms.2
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oXHlh1GVe6XHIGjfxqBlGpday517k1tv+6ix4arA+Zg=;
        b=mTElaErKpyr/9+bfvnELgYwdkqnRrQO/qiv+5Uq27OCgDaLZ8aaksxAjd9sARIF4ia
         /MKEh6h6m5FSzyCivP3eglyAgdt3BzjqP26wkFUqzy2+/dG/8NmUZ9FlogJnpdCcldb2
         acKe0v4SIDaiXlfpQSpvIWPAs+IMm42n+sNx5ilNe2CRyMLhb+Qf8XUxMGpucgpCVr/5
         0xYCWc18aYTj2u9uyVm24v9OmlUdvlO9ti00jk7Cxckx4+EiBdL7LzF4JhLmGJ/0jnTk
         phGT5/FRGPYaX0W8aQOgkpWZLLlyatLsvD9LaqDBhKUfBRUYuNa/ewbjRDB8VrtWU+Az
         k2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXHlh1GVe6XHIGjfxqBlGpday517k1tv+6ix4arA+Zg=;
        b=B+ij/6MWwqmybh+Nd77Gi6ppfthk2ZkI4nw/+5eedhSHaEaL9QGiIwfbTyfzpDEzQg
         mJFuVGKF52kFjRJ5MWHS8pjaOzVLqaK6P5LuuDQqg2f9kaDIgr5CSmCkKYZP8KiowCxe
         uZsCbNbQwQyPkb4H7Xft8NzW/MEtFnujE9ExYY/5FmDnAtrxCu9VsPqqg52gGlpKUi+0
         CJGb5TAljtjMR+fEqx/s6q60Lf59/snRWtpgSKJuEeqnnDOs9P1TUAUzRIIiaeyWIX9A
         xrg1t0nx3iNTSAsnnn28xqNFvWb2SiyTElVAiX9AZvD1pIQVHRopNsd4lWvTxz55y+w0
         whig==
X-Gm-Message-State: AFqh2kqQL2nBqa5dgCilv+CL2x/I/v+ioCebvQSIO++jD3ypmNaDAz7l
        co56xnRYK5zIGHgV0cxl3rh3Jg==
X-Google-Smtp-Source: AMrXdXv4pjrlJCiDM72DBhh38Wa+y+wDQd0b3eQquuYXJF+qOVFv9nVUL1oHgw77dN4sbV8WLhp+iQ==
X-Received: by 2002:a05:600c:1e1d:b0:3cf:674a:aefe with SMTP id ay29-20020a05600c1e1d00b003cf674aaefemr24094598wmb.22.1674487004649;
        Mon, 23 Jan 2023 07:16:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b3d5:343d:5dc9:ee00? ([2a01:e0a:982:cbb0:b3d5:343d:5dc9:ee00])
        by smtp.gmail.com with ESMTPSA id x15-20020a05600c188f00b003db122d5ac2sm10449596wmp.15.2023.01.23.07.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:16:43 -0800 (PST)
Message-ID: <767eb8e4-fba7-e25b-bcd3-3f05db9a6d80@linaro.org>
Date:   Mon, 23 Jan 2023 16:16:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 01/13] dt-bindings: serial: amlogic,meson-uart: allow
 other serial properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23/01/2023 16:12, Krzysztof Kozlowski wrote:
> Reference common serial properties bindings to allow typical serial
> properties:
> 
>    meson-axg-jethome-jethub-j100.dtb: serial@23000: 'bluetooth', 'uart-has-rtscts' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
