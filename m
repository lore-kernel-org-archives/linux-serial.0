Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78ED297A45
	for <linux-serial@vger.kernel.org>; Fri, 23 May 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020444; cv=none; b=eaJpa0aHbUerui8Jur3iG7PvGzGD68MV2WYabkN4nnd+uYrJAVJ4ZtbXmK0qSXt4npp4eeLeiQvQNMpgirjPqvUZQsxgW44ISm7h8HPg146RbqQIMaE6mfTXyqHc3ZsgErApM7lsDuIEzEp1FgERRlY7Uxy+ctKbF/loD+h6GKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020444; c=relaxed/simple;
	bh=q70KRtP/Ls/EnPfjY52Cg7+ufdVGyh9iPZ62lGJOoDc=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=BlHg92ovMi4q7Ji4uxgjSvC8oJP9tZ1M7djvU7l55nZ7B+IVpDX6DcxrA2X6lQrQcCvSF5K1hv8ZlnF1+C9zDclFXaXVn3iL0GNr0l9XQsByV/P+8G3quhHBjzhSbojOrshagPMAezcWi4M9qWkMyEHLb+5gpb6cxfFoh6l3Udo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cRmn2osA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cRmn2osA"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fa9ce24d44so1388926d6.1
        for <linux-serial@vger.kernel.org>; Fri, 23 May 2025 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748020439; x=1748625239; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6u9v9rOB7wDSHj6qtz/FEqNxQ/3givq7zBFPK6aaZeU=;
        b=cRmn2osAYRU5wL9NyNSmhj/NzV+WHj70LaKZOl9KV7MnCbdts5++EiMK4bdaXhkj7G
         o6hsQm27Dy9+ISVcd87ZFaT6GNhE19biilGQ8rNGroFsBceHF0xS4QOV3fkCy7XEx1Tz
         uzz1dtgLl+ub13go+TCvoMiKiNj/gSXUaIZySMajYCJfcS0J7Smifonr/+J6bhgMOCaT
         w5i1bLtcORUoup8ttMzq9DM0bq75ikO//WdHzSWDY5VQg/xIpYK3oEs7YyOPpzmSDmvL
         aDyzVI+Zynk+SUqjR9PaIjoV4dvyrjKp5KT2gL1X6fqkjbMhpcwvIIUEWErKmJ7Zn37q
         WLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020439; x=1748625239;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6u9v9rOB7wDSHj6qtz/FEqNxQ/3givq7zBFPK6aaZeU=;
        b=C5ltLh+AtMq4K6r/wAMTGlFOrpS2jprTc2GpfZ7+E9x5NnfCEhiZTA2kLbr91noEYE
         dH6u18oYTtglqG5FVKZefD0U97Kw8QVphAQ/I1FaojHwVjnNri87vB2QsAx66Ai2LGza
         QcZkCSrieOQ3G4ysc+Dy9aunIDdFFEA8gEjbFBlHMk0ndGAI7poDgCzvrtsd8GBiZIUo
         N3GtbDfIqzvBYdhXJbA1DcnTKJBClZgzv1Lg4tVPmsQWSlF1Wj/j9qN7iaaBqJ3jmKM6
         sTweBh731nFKYL544zY072I6V7Nw2KpoJyv5aZ5ii0tmlkQLcW5JoujbjGkWoNugK7ES
         spWg==
X-Gm-Message-State: AOJu0Yzlp74F+LutwHENqPIA46tLb/SmtNJk9gWFitmdoFtG4DP0Ol5m
	tKNq2VLcyPlf/0pH9uTL68HPms1fGojOwJixfjnkNVrKSSIuUzCNGXGr5FwrJg4kgd2Vrj8qlgi
	3P1eW
X-Gm-Gg: ASbGncvgIvYdnlN8cxD6W+ootpxXr1ZdSAXUxZCcbE1kkxGt7rNulwNevoz6aB3sGsr
	FsUGzykr1cO2YBnHOzneUZZOkAMiqGiMUalVazskJ9j1ftslaCUAjbYdSXr3ei9Igbgo8sh9Y3z
	WtEWv775vZinx12+F/ZAu7tJ/lC+ri77q67UvUV0QzrqqCwXsbp3nxnvoJM+YHr+k9DlM6V7L4e
	+zjPdRYZNXgddudxvckWJs/FdskNIzdlDSfTXFUcxeg80XM+mePuhzwb6b51o1t1wPpn5LCRhzn
	DOFa1hIdF93kmZ1pZGqXjzh3r47TFI0cM9r6S8lJutDLQWT/KqHuL7N2pWFIr1YzucSHUvAlx8h
	ETOSdMizUpEpnyQ==
X-Google-Smtp-Source: AGHT+IGJzuu4ZXXeX5BlecuVuFVZZwA/bCwL7vxRk1fOvReZtV8zdHQ/t63ghPaOuxghJs5IcqbiTw==
X-Received: by 2002:a05:6214:764:b0:6f5:e0c:b203 with SMTP id 6a1803df08f44-6fa9d176d43mr5501356d6.11.1748020439667;
        Fri, 23 May 2025 10:13:59 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fa99a641cesm5782186d6.53.2025.05.23.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 10:13:59 -0700 (PDT)
Date: Fri, 23 May 2025 13:13:58 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vt: remove redundant condition from redraw_screen()
Message-ID: <n58o097s-s20p-4222-nqo5-2qp26843rs35@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Given !con_is_visible(vc) is the equivalent of *vc->vc_display_fg != vc
we have:

	struct vc_data *old_vc = vc_cons[fg_console].d;
	if (old_vc == vc)
		return;
	*vc->vc_display_fg = vc;
	if (*vc->vc_display_fg != old_vc) /* !con_is_visible(old_vc) */
		...

Therefore the last if condition is always true.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ed39d9cb4432..af5186d2c219 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -946,10 +946,8 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 		*vc->vc_display_fg = vc;
 		fg_console = vc->vc_num;
 		hide_cursor(old_vc);
-		if (!con_is_visible(old_vc)) {
-			save_screen(old_vc);
-			set_origin(old_vc);
-		}
+		save_screen(old_vc);
+		set_origin(old_vc);
 		if (tty0dev)
 			sysfs_notify(&tty0dev->kobj, NULL, "active");
 	} else {
