Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A03CC352A1
	for <linux-serial@archiver.kernel.org>; Thu, 24 Nov 2022 12:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKXMj6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Nov 2022 07:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXMjw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Nov 2022 07:39:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3877DEAD0
        for <linux-serial@vger.kernel.org>; Thu, 24 Nov 2022 04:39:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l11so2396630edb.4
        for <linux-serial@vger.kernel.org>; Thu, 24 Nov 2022 04:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/t7lNXd7tivgAb5igBDrtCfwGh/wo9NfhZ6XZkO9LQs=;
        b=CwAwnhaZdX9OilFLK72ch9GrUK0xeFxcVPhlg6ATs0/jojQfK+OA2PP75ZW8SGcqhZ
         2IFFfE+r8r6ZxNlGsvxG55gcZf2PCYuTlv5p10KSAeIwUZQdTIjmdIHXIzKJmA6oGaq2
         5n1BLEko9R0m64dyS3wXLZrQHGKyCX1/NTzzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t7lNXd7tivgAb5igBDrtCfwGh/wo9NfhZ6XZkO9LQs=;
        b=0qwyzCWhIkpw3uaxXHUX38OCuXIRmRKxJzCSuC8vtyrQb1oj21ZoI5yMbxqr9BBrS2
         mnfp/zgTVLhNaWilwYDTQyhwRPyyMzGYOdbV2MGxQ4dYN6iieZ2RQCWYJkSYAtJoomXY
         w3DizdhQ3twlZm7DETKSJEGeT4+BrdqvKbnUufa2AsEMx/6gqye1GnTHE9hJUH1CAfDs
         mluDwHewbkv5k6sqzvLQhnNE2z/Fabgzj7+AfJJz1ZPAIUWhTFCYYfLLK6ZikbDXon3B
         5iAAOipbS8g/X3WbGa5PriF98VDw9fnK5cmtxaH8SVh0VhWYI4DsGIruHkjeqshTpdJ1
         FV5w==
X-Gm-Message-State: ANoB5pngNnPw7wI+HPJVdah5tMbkKKytXoiaNNCqYLc/MMD4UhoBhlL6
        uO4ipg9SSbHtqo42crBRHeCvLg==
X-Google-Smtp-Source: AA0mqf7RWd1s9LEmT8i9v0qAOm1e/Wra1pus7ZxiNmj5yo+3v/7gO4B7AHB133rmFVhRCIVRKBzm7Q==
X-Received: by 2002:aa7:dd4b:0:b0:467:65a2:f635 with SMTP id o11-20020aa7dd4b000000b0046765a2f635mr16516340edw.106.1669293574328;
        Thu, 24 Nov 2022 04:39:34 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:7b70:9ff8:7491:883a])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c991000000b004619f024864sm462866edt.81.2022.11.24.04.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 04:39:33 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 24 Nov 2022 13:39:08 +0100
Subject: [PATCH v3 2/2] earlycon: Increase options size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221123-serial-clk-v3-2-49c516980ae0@chromium.org>
References: <20221123-serial-clk-v3-0-49c516980ae0@chromium.org>
In-Reply-To: <20221123-serial-clk-v3-0-49c516980ae0@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=LDMEvgd//6KOjPTqmpYoayiLmRUHZGWV9dd55Hylf3E=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjf2YAMvEHYcx8DY5+AyWKex9Y2BerkLgm3gHjPpgl
 Lm2EtbaJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY39mAAAKCRDRN9E+zzrEiNv0D/
 9m3hYtxTUDRJdqKoKkRknZf1ck19nhHvyghTUthaohqBuzLJrkgAvs4nJALziTZieMc86DW69gwDnD
 QQ6jU5wvwk7JiBJ7Q3rKizf8J+JDt6OGkrI3CWNRLwpUd0ocHAEv/nqzmjLoVtlTV9/sLKUqwYQuwM
 vjueNem+8ZClKf8wDYXy5zDqrMf/2MkvJ8Im95tFm/JWnzYxp5vCzHQLT9jjBY1Lu1JkcnOTMte93X
 5odbnGsQitXvpi+kVeX3cY69OFqk/AM+P8Carsv6TLulDvkJCvs3reqIGKRVCiXNkyde781eEr+jlB
 F6gSAnVWb6C72lieHHdR7bGOPIaunJSTdEKl5TfzD08FnavmA1n2i/b1haMA/wxq3VkiyfrvUFDhDC
 k6NzwddmRtAzMdfu4SoI318lUs9mFnzETr8XamPGVMic5LmWyumFl5QDKj/9juop6/RsnK4cAZJAZq
 sAmpbjwxPQgbi75UQRG/Of3LxTr9FPhlbmaV37vuGrkIC+liFqHf4YP2L5wfeX/ullD3cIZpoe0+LJ
 +a80WcGzcvhIYi2/8xhQ3V6yJomX3QuqMtjGHVPpIUe7J43YUwbv4X52OOiEbBMvWNq2+DjDoTGkd7
 yUrkKflmDRyfHfx5v7G25WwroG5Pn0GxlRRefxDH/SfUyx9RMG1+t4rWaoYg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that the clock frequency is also part of the options, 16 bytes is
too little.

Without this patch dmesg does not show the whole options, Eg:

earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200n8,480000')

instead of: '115200n8,48000000'

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d657f2a42a7b..f555927195da 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -701,7 +701,7 @@ static inline int uart_poll_timeout(struct uart_port *port)
 struct earlycon_device {
 	struct console *con;
 	struct uart_port port;
-	char options[16];		/* e.g., 115200n8 */
+	char options[32];		/* e.g., 115200n8 */
 	unsigned int baud;
 };
 

-- 
b4 0.11.0-dev-d93f8
