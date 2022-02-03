Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C9CC433EF
	for <linux-serial@archiver.kernel.org>; Thu,  3 Feb 2022 21:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbiBCVjj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231713AbiBCVji (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Feb 2022 16:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643924378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+aX6flYCGlec8MUmzayK91nF9NO+GezhygAiZUc4qds=;
        b=XDdmpiKbXyceFjFUG9OEyj4QKgjEh2jzCK94RUP+xTl15s2QxgrSXKeagBmd/jgT5xywfW
        wQb3jnsaMiL9PqA61K63rC1j5nlArHUc4LM96eV/rOZ3VsNxLprmmaJDcoQeuUucrbH6Pr
        s2PKujrDKuCO60SquntVEpfplTHFF0I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-nJ4mMu9dOWKBbsC-4IkUdg-1; Thu, 03 Feb 2022 16:39:37 -0500
X-MC-Unique: nJ4mMu9dOWKBbsC-4IkUdg-1
Received: by mail-qv1-f72.google.com with SMTP id ej14-20020ad45a4e000000b00425d03eabe4so3660912qvb.9
        for <linux-serial@vger.kernel.org>; Thu, 03 Feb 2022 13:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+aX6flYCGlec8MUmzayK91nF9NO+GezhygAiZUc4qds=;
        b=U+Gp4CcShBQm3GgRjnk06B+VyNBVlZb7lpjmqwCkYrCVNF2xDOJlvc+2VrHb3SdUQm
         qf22iKs/G3jm1ce/qCEUp6DjrOiNDW9SkgrQDB9zJ2z/0CZFCXMP3N+mdznEv3eZU1YA
         ZEj+os5grDYYN1FQULw5lUETj1I08P6SQ4x34pJEzHxMdQgNU2rYZ/qOFrnI8vb/k+j6
         buWxQY3h32pSwpDMlqOIcnwz2pF7Pao1lgoFHiw/TsO7pZd0GHKaiIHyinJTfSfViH0J
         d3PjRbPttP2B1GbsuqhIZYRYpqSSLX0yF8yLg4MydiEGhV7o/2wjRkvqM0ulVqoZp3cG
         iYig==
X-Gm-Message-State: AOAM533qTOVKON2xIPFdZh1EJNM7e3DjoOV8KEII3J5kKfYsoe3GUOgd
        lLQicKrRG0ucXwAJEaBE4B0hYt+E985r3aaq49ZPfXcVrlus7TeBoDA8K14+q95Rl/BhNCCRYUP
        WsBgKVFFbG4mEyjp7WnLqLqil
X-Received: by 2002:a05:622a:1aa0:: with SMTP id s32mr86333qtc.145.1643924377051;
        Thu, 03 Feb 2022 13:39:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuJzUTTqRgkam6YpJQj0YsDVjx8yNmuoFMgpLG51XVIvp7iv7xlN6IdGc1fnZzDvFnEuKkIA==
X-Received: by 2002:a05:622a:1aa0:: with SMTP id s32mr86319qtc.145.1643924376896;
        Thu, 03 Feb 2022 13:39:36 -0800 (PST)
Received: from fedora (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id u17sm22096qkp.90.2022.02.03.13.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:39:36 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:39:34 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] serial: 8250_bcm2835aux: Add ACPI support
Message-ID: <YfxLlkQsHEb2qbjW@fedora>
References: <20220201185001.926338-1-athierry@redhat.com>
 <412a456d-7294-a124-8a01-f052915348b4@gmail.com>
MIME-Version: 1.0
In-Reply-To: <412a456d-7294-a124-8a01-f052915348b4@gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=athierry@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thanks Florian for your feedback! I have submitted a v2 with the changes
you required.

Adrien

