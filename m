Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CC8C001B0
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jul 2023 17:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjGERaf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjGERa2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jul 2023 13:30:28 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763B1990;
        Wed,  5 Jul 2023 10:29:53 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3458a08310aso30399195ab.3;
        Wed, 05 Jul 2023 10:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578182; x=1691170182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIkUXGDF7cJQPtOQc9W5fAR7XWPQ7kmXvuiGky/kf/E=;
        b=f2my/2YKgJaR1dukc6pRJqjxfiN5z4IMIQT5FAmOMULjU8r7XKVHx270MIsaqpouP9
         kl4NmUWyA/4veZwiihSMRjkIM6fbiKCo5gtMGeVENXHCY9vYpKYqasOH7DiCx++thRd/
         Ae3D83kWyUp53/tfAkpp7OEuLHFutE2jWpjvjgGQdiprl0Qv/D4a4yIvaeU+nKqTmjNM
         wmX3dmrA2oVQYoUKBpuEWUff/B3whSCR0+pF1xwqXGo8R6hgZN2tSPSb+VE0UNmsvA9C
         0iO/rQDEZ1qcdHsoqAFcqOQ/qUSLYbpWbRgabPFoyGadGBDc00nndQWeT7GByS6dURnz
         MMTw==
X-Gm-Message-State: ABy/qLZKww/E6ZpztlHGmA/v7uuJFFSxLCqJnbY897lm2Jn+Ly9jjDam
        XxC/UcNwCZBwO3iEcxUnUg==
X-Google-Smtp-Source: APBJJlH/RKzl6RmIwgaz7MNvEOPO2bJWlFdhCsyZsPelPTyeiXiKVK1JEI8aYF+QS3zYaGTK9aDZfw==
X-Received: by 2002:a92:d349:0:b0:345:8abb:5b2e with SMTP id a9-20020a92d349000000b003458abb5b2emr16366870ilh.20.1688578182075;
        Wed, 05 Jul 2023 10:29:42 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m7-20020a92cac7000000b00345d5fd85afsm4662693ilq.70.2023.07.05.10.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 10:29:41 -0700 (PDT)
Received: (nullmailer pid 1138244 invoked by uid 1000);
        Wed, 05 Jul 2023 17:29:39 -0000
Date:   Wed, 5 Jul 2023 11:29:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-serial@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: tegra-hsuart: Convert to
 json-schema
Message-ID: <168857817923.1138059.11910851731139358305.robh@kernel.org>
References: <20230705151802.2512186-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705151802.2512186-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On Wed, 05 Jul 2023 17:18:02 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra High-Speed UART bindings from the free-form text
> format to json-schema.
> 
> While at it, also fix fix the example to reflect the correct compatible
> string for Tegra30 chips.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add note about the corrected example to commit message
> - collate all single entry compatibles into an enum
> 
>  .../bindings/serial/nvidia,tegra20-hsuart.txt |  73 ----------
>  .../serial/nvidia,tegra20-hsuart.yaml         | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

