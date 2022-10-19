Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171C1C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 19 Oct 2022 20:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJSUma (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Oct 2022 16:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJSUm3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Oct 2022 16:42:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFF7164BE2;
        Wed, 19 Oct 2022 13:42:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sc25so42703371ejc.12;
        Wed, 19 Oct 2022 13:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcsg8Nj2+GgMON9OjeKFtbpRu0zVg200Uay12BT+4rw=;
        b=lTZUxcN55a/Z7QlxcVEnEaxA0jFoiZIRGBXk82beJ1FuxIdx3GLG/eIwiTyWykAMpE
         ndkE/z5OQjwIIMzit54N8gYVBL/gyPOOWkNVQosBvJbVH68p10uKxttAiUqreCJyrEQb
         DIVlXQABCF6qQqMzjueFzxihAFtULdLoylaKiZ9v2ZO3oVOzh+KM2qoBKfGWUiCv/wDk
         Ma4UXd6RwB8lBruHSrsImTyWlW7XRodF4GNXZbyHN9WSrXhRqEBmGMekdl3xXtfNb7BP
         kqJCvhxSBcYhpq2xlonz9JyGxchiegPZ8UxTkzOUiJncGMNXzk7V9genrUgF5y4b1+aW
         4mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcsg8Nj2+GgMON9OjeKFtbpRu0zVg200Uay12BT+4rw=;
        b=heiLEZqaMYxo0+ySzY80vaGYw4f6iMCJho0wLQLKKJnyVk03DHGUk2TdR0CvIdFcs7
         oclQnxIeK5HoBkD7WjPc5c9JGLbHBYMMrzZi97S0TQoCFmMGVkRdweQXR6nt25qUrxQ4
         HxPju/iKXHrmhTiB3HkgH/1JziiS7DTYXGeCTGcEOq9obvO2g+AowP51pSyFNG7tvmku
         Mv0dmnePSztpxbZ+0F4oyK97FdFqGWdxck74cyvdBhLo75SoGpyvLa1IMJ9zum4g6Lms
         d9bY1d/JI2VrQOQ1s4mrhbiIqVRxN+j3l8mmxa6bQT6r49OYxKm70IkmJBTLMKQmTR0h
         GiHw==
X-Gm-Message-State: ACrzQf3NkNFt9VrKgzhZtAN46BNPDNBxqXuMVMx1HUXul/Npa5MBeTTd
        JFIiVtpRE0KJIr9BDdCu6/XvknOuSZtXkasGr3s=
X-Google-Smtp-Source: AMsMyM7bX9T37uugRlFWo/3gcD4LAF6hSqosi43o4xXK+sd9ErmYdEO1bqm7GMdz18dg6QSVsHUnMr7qM1RAe4qnJMU=
X-Received: by 2002:a17:906:7314:b0:791:a45a:bc84 with SMTP id
 di20-20020a170906731400b00791a45abc84mr6202359ejc.394.1666212144504; Wed, 19
 Oct 2022 13:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com> <20221019091151.6692-23-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20221019091151.6692-23-ilpo.jarvinen@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 19 Oct 2022 22:42:13 +0200
Message-ID: <CAFBinCC+jT65hOArEOm7BWbxraLrhhn5Dfeg7nK0rv3nUjA=WA@mail.gmail.com>
Subject: Re: [PATCH 22/44] serial: meson: Use uart_xmit_advance()
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 19, 2022 at 11:13 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Take advantage of the new uart_xmit_advance() helper.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

That helper is a welcome improvement in my opinion. Thanks for working on t=
his!
