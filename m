Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BAAC001DB
	for <linux-serial@archiver.kernel.org>; Mon,  7 Aug 2023 13:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjHGNum (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjHGNul (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Aug 2023 09:50:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C7E79
        for <linux-serial@vger.kernel.org>; Mon,  7 Aug 2023 06:50:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5230f8da574so1652600a12.3
        for <linux-serial@vger.kernel.org>; Mon, 07 Aug 2023 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691416238; x=1692021038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJvK32hfp7W2IiN/EvVttylVS5EgMni1Y/4T65DWePg=;
        b=L5ZeOA4RaGuzqdd+ADcWzq9s/f1sZ4yf3ThmLa07nCL0zuDUx5mgGPA6nvy47kNdyj
         S+ASwiMDNoWGciC4wW+UaqyQLBhvyiQhSlwp+Ikr6iIKtqp4iC65B7YKOU7mBzPKFQFL
         Awn/67aAFv+VBTrNhXedHHEIY/3ka9vR6MyKCE/nDoNm64E7/1VVxGHPdnGWQZ+Akw6K
         ZJlEOJilxd/sOHVsJ0uDEYOOAtKHhMC4Dx60yd+PJQ+mGgO+GipECtK4d+WJ/8TI9XuU
         j2E/qNXWukiehaVOAAsh+2/R8fIrJEe/ro1EupSBg+nzTbaRbhNh0kaMqjTrrKfvHwKn
         RVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416238; x=1692021038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJvK32hfp7W2IiN/EvVttylVS5EgMni1Y/4T65DWePg=;
        b=XLMlRfAPbNC9oJ9HSCWJYD/whAvMED1/gsQEFmI1WeE/EVvCuyTitG5M50EAzMNWCx
         srRDfQ3NoMrxlVeG/eqJ7CXdOpEeXbe+kD97KP4kx4Lt274VIkJQA2AvopBz+wcDCFMj
         gxhIA9jmz3mjKXLvG+XdURSw2v4ultKbj0UMUcVx4LopdfUpAJUoPr2zwK0eUvI3YRto
         lphMGCT6GUtwf+EmU2vN7IT0Tn0+iUGjC3kyYx5TPS8iqmiz7fuLuoXtWOdnMRENs0l4
         NNc9q5q28PMSPINDSBArfytcQxppTPYokhCwluc1M/q/1W5URYUOMFkqF+O+7JJQtL5j
         OrZw==
X-Gm-Message-State: AOJu0Yz3GQXumM6z6el/7Jyck1tl0XjEG0AWrGfAgivFTBAs//YwsFXe
        i0Iqyt0+m4JMoNkJcnUmNKmbLw==
X-Google-Smtp-Source: AGHT+IEpZcOZrB1JjhLGm3EtdG7FGURcI374JR8G6zMsbVKzVKzlpVS/LBHaKsa06lDjpvqguJ0d1g==
X-Received: by 2002:aa7:c651:0:b0:522:3ea4:81a9 with SMTP id z17-20020aa7c651000000b005223ea481a9mr7731992edr.34.1691416238152;
        Mon, 07 Aug 2023 06:50:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id i22-20020a50fc16000000b005232e637c24sm2512196edr.84.2023.08.07.06.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 06:50:37 -0700 (PDT)
Message-ID: <9967fa81-f3f4-04c4-a837-d507a19989cc@linaro.org>
Date:   Mon, 7 Aug 2023 15:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tty: serial: samsung: Set missing PM ops for hibernation
 support
Content-Language: en-US
To:     Anton Eliasson <anton.eliasson@axis.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 03/08/2023 13:26, Anton Eliasson wrote:
> At least freeze, restore and thaw need to be set in order for the driver
> to support system hibernation. The existing suspend/resume functions can
> be reused since those functions don't touch the device's power state or
> wakeup capability. Use the helper macros SET_SYSTEM_SLEEP_PM_OPS and
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for symmetry with similar drivers.
> 

Looks sensible, although you should also test the other sleep methods,
e.g. suspend to idle.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

