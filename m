Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57282C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 11 Jan 2022 08:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiAKIYr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Jan 2022 03:24:47 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56212
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235025AbiAKIYq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jan 2022 03:24:46 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 34AAB3F1AA
        for <linux-serial@vger.kernel.org>; Tue, 11 Jan 2022 08:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641889479;
        bh=RlYMk8d+v+1iEbphE7wTAkvSOR/8u38JKByqwypBsb8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Lm153ZohCxPkwWIZesvRD92Y+FWTJOh3aZhSDmM1A/oVSdEMMhdX/2r2kzF+s1LSR
         ZCAysbNcHQHW709kxXFO2mttqRMqy7YSwmtMbesuEpj9qJJzEZ9VL9FRHmwnjUdakj
         FICOMEUTAaIEyiZ6B2uRTgmo05C4ycPYYGKFFxeLQ4CBoxqDizvGjDAdCs/Zt9XjOa
         PqBHXHDazqc7INEthTsKCG41pvHLh5a4LGFZBNF9vEDxX3O52c2Nhkrz3Avjmlnxxn
         N621w9klIKTBktu30OLpqzpq+hlMt5G1FJQjgYMcRAVR4eeFoput2iqZjOSpSEnrLB
         8UgLGPwhtN1gg==
Received: by mail-ed1-f69.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so12614468edz.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Jan 2022 00:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RlYMk8d+v+1iEbphE7wTAkvSOR/8u38JKByqwypBsb8=;
        b=SAPgnyafzMIk4dSsYrQzOdydSYCVhvzhTfzPSaGc0cBvXGdtnMR2Sxpo2K8SUvVT8E
         N6rDtiisAk01lWzq/qs4q061NAp370huD2AGzIwRV6B1ly4UmQ8Ih9AG0F1yfSyXYrc8
         lmKrA2ZBignB4zbLLx2lp7u6V2YrIpi4wcUQBn4WED228OVvMV7uMyHvf3MEXInjzMy9
         oWigqbNN05+99kDfvcWvH3kIXJPaKGPDo5Gfx/ufwZpkOlfLDPvUXmI62TEmXV1CvOSa
         a5kaM7xR2TckSWF6gih2A5r+2utav6O2DnLEmGdj5+4qpNaxuCz6QCQN+xZ7ThFden5/
         I5YQ==
X-Gm-Message-State: AOAM532oXAywBwipY4x8JASIk0zu4QNrkcWyh0oJHVOaxk/VfDzaJAwn
        L6wYCK0aKyjo0yt8c8GcY/TMnCRi0JQKbVrN4M2MQgEz05ZRr/w1jR+Vmp9pu5YcdzAOUAfBHb/
        ObMFM23oYt+JEyK0P5H3rAalduBB7fkNKOUcHqj9Pow==
X-Received: by 2002:aa7:cc83:: with SMTP id p3mr3203685edt.382.1641889478711;
        Tue, 11 Jan 2022 00:24:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKoaMG4DzJPDmsJxeBkG8NBA12PgQ/03+cQRBY7Ozb0pIe/kxcZthl7BTrnasE0CDNDFSqxg==
X-Received: by 2002:aa7:cc83:: with SMTP id p3mr3203677edt.382.1641889478514;
        Tue, 11 Jan 2022 00:24:38 -0800 (PST)
Received: from [192.168.1.126] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h3sm2337887ede.32.2022.01.11.00.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 00:24:37 -0800 (PST)
Message-ID: <21f01245-9bcf-95fc-7781-a8da02029783@canonical.com>
Date:   Tue, 11 Jan 2022 09:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] tty: serial: samsung_tty: Check null pointer after
 calling of_match_node
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220111081647.637752-1-jiasheng@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111081647.637752-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 11/01/2022 09:16, Jiasheng Jiang wrote:
> If there is no suitable node, of_match_node() will return NULL pointer.

NAK.

This is not possible. All drivers have such pattern and it was
discouraged to add empty/dead NULL checks.

If you think returning NULL is possible, please explain/document it.

> Therefore it should be better to check it in order to avoid the
> dereference of NULL pointer.
> And the only caller s3c24xx_serial_probe() has already checked the
> return value of the s3c24xx_get_driver_data().
> So the new check can be dealed with.
> 



Best regards,
Krzysztof
