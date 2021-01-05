Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65491C433DB
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 18:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2270822D6D
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 18:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbhAESYh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 13:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhAESYh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 13:24:37 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA23C061574
        for <linux-serial@vger.kernel.org>; Tue,  5 Jan 2021 10:23:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g24so1617567edw.9
        for <linux-serial@vger.kernel.org>; Tue, 05 Jan 2021 10:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7dXcqeLHf/FMxBSyHLovWXUvXpzSB49eYDEiSZMKJeA=;
        b=TmngahV1zAE0HyBX2jBnnJB6lbvm+N4eyHDCz6e4b2MBNw7akH0ru22r6dhUgWXDWI
         lQLjzJo0MKUlf8A5Wjri/3gNXksTFnpKz81RP68Od043IZx/ENpiHJChTvz6nDN93MMd
         2t4x1AGbDC/4DvaIrSiPYomcRo8YnG5xcrtHcLhAmvbtf0+2BgXVR9Crx/ZtCod6Bv8F
         IpUq4bV3cdt3ISc2kwhSCpUqW2b14YzST3C8rHWOJzdkn8/Pt6hibBTEEXRz01vaimvs
         66TtxeHhNvkgb3wIwqmdZaXbQp/O3X1if+YBOfjgJY+8UHMSDz5EXSkTv4hM06yyq7LL
         IS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7dXcqeLHf/FMxBSyHLovWXUvXpzSB49eYDEiSZMKJeA=;
        b=QLWN4IdVrB3c97U7lgFczetnqzSwENWAz882vO2H94ZmG+bb1N+2Mvkr7m88CmXSlg
         DaXtqe0bxy/vWg29URL4QbgVetO6YvYmNY16FEtM6qrkBKyv8KjbyN/hLwDy6za832JL
         aD8EhGO1QAovbtenUGwGKpLFHzpGvJwU0Lcl3QUaIhGTRL68BsRO0MGS/PC1NsJBhPKJ
         Hm0ha4pNOECvSTo0SuOF9WMc+3VdffP8orgbMNaaULhtkAceHywWviLEz2xIWa5D5Eqg
         UHMKvGYTc6GljjBOYwhGwsZqd+xGrKcIz0vraHPJkpbu5AQL7vYjq0Bc7LE7lJq1QUrM
         pK3A==
X-Gm-Message-State: AOAM532+tiWd7xCFhIF/GDvaMBPTeeKoHv89ZiWzlAL0Y16Le4x5XvdP
        nidYmPRC/sIDGpEboc+woecvRdWl1ZY3cfPoCDKelw==
X-Google-Smtp-Source: ABdhPJx+OGjzRjuHT6CuJVFCFu37Zr+M3TCT6z/5KN/72u6Ne5EADP2ghsJi/3EUU7+ZnkxP9I7plpLg7BFr/Hi89KY=
X-Received: by 2002:a05:6402:1597:: with SMTP id c23mr1108306edv.212.1609871034788;
 Tue, 05 Jan 2021 10:23:54 -0800 (PST)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 5 Jan 2021 10:23:43 -0800
Message-ID: <CAJ+vNU1XJCisZWpr-huf5gt3V592gz8kX+VHga58iM-Kx+h5=Q@mail.gmail.com>
Subject: Linux gnss driver SPI support?
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Johan,

I have noticed you maintain a gnss receiver subsystem and according to
the device-tree binding Documentation it looks like it supports SPI
but I'm not seeing any code support for SPI. Am I missing something or
would that support need to be added for use?

Best regards,

Tim
