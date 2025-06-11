Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2F145B27
	for <linux-serial@vger.kernel.org>; Wed, 11 Jun 2025 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749606111; cv=none; b=HbQ/w/KZOCGhqKEe/zAH15BNyud539oaCiZDcmiVb/O/vS1LfFKPjyREdodh8mkaK0B/m2VRBsnwCW53/B6AV0VNPZOt7ulmdOANGkfoii1Wy2SvEj+DMfjY64nvLwBalWQYtEvzsuy9eD9fyd+DSGDQoT2qU8ZBNsvtba4rLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749606111; c=relaxed/simple;
	bh=2kNFgJvFiHWl25tdl5JVTyWrVYRncCS6MCCO8o0uDrQ=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=O1B742TQpqcm+fWaRMie34hjtoueZqqsDexYa6X4PMegWnHoYl1cncRLNUG5LVJM3LKFmX8UcBbdb8eJmjETqmuaPA36tJVtORqtRp7IGQXJxEeBqe3xx7wRl+VLJui8ox6tUFpM8n3g5oOWJaPHrA/lc4EOdbycN7OFAW2rHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ppZxc4ID; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ppZxc4ID"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476a720e806so56174301cf.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 18:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749606106; x=1750210906; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a0dVcb4mCq2bSSy46KTU9Gw7pSw3OfMXBWad0p0FySA=;
        b=ppZxc4IDbRUpxdKr8t652woLHg1RyzQxv/RuyP2R96pEolTyaXs0QsjWTRDtS0/L5G
         OujhCqUreOIEu+tkuhuKLcWeWrUq4MWT2PpN1BTtqqcuJZypUUzGoCpAx4hQWFheEUaK
         r0QJBYGtGpYoywwBAzvMHAcVcZ9kHcjuI2MmdPVyf80JNxWQCQ6XDrI+cp5iFBOyzRB+
         +XkxuTeQD8vSJjouarr8do/Ne9GMBkEdnOYtZYZfBtcCHHqSrFo6XwDIlDuUfTkwzes4
         kUEn+eMpwvI1dwl13B2AmgxXt3LOXcaf7Jcasj+V4bD2OWkMtDEas86H3kCNVlq+I63n
         dbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749606106; x=1750210906;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0dVcb4mCq2bSSy46KTU9Gw7pSw3OfMXBWad0p0FySA=;
        b=aC9DkH4iC6ul/WLhs4xxXAxTPicUMHN7/rpL1UpRPdy/e9SauDa0ZaRNqxBN7WHJwX
         XKS66dmZlbcyb05SJem9TwqZzy4ObNUNqI4ZMW0xj3mgGmr8c1H+eDx63Ae+G27NJvM9
         dnnOgl4uyPtT8WYasAEL4OzLCJB2CYHHT5usxncgyLSYI7BbIJrhBcsylQdZ/ySh3AVK
         4Lo040507p7nXoevXNNXYR0xo8vJuEJD0FqB6vdrnsUspEiOJ4Cd+fMHTQoCCLE7u7gi
         sOG5brPILL/wTIMM+TpB5pCYQ6zG+w+yVBYT1krrpyLLnqdYZ3HhsvxKLUY5sMw2seY/
         j9iQ==
X-Gm-Message-State: AOJu0Yz5z2JocEedA0Odiq4ZXyG8vOFnOwP32b68wp7HoyppIiuOUkU9
	kVfylge634SbCvcb1U2d7e+Z7U6BF4ZmUhmYbsqciScevSpmViBugITVOtGSeo0ixCR0z1WVSld
	nawnn
X-Gm-Gg: ASbGncsH+9z26tzaMt2neVfLIlKPzTXF/g8x0ujW52i5cj4QpIJz+UlpCc8nraLpPYy
	8EveAB/6G6glDlGXKF0wSvGROnwhoe3t5nck1A1TQarOCuXPiRDs7gY07hAYCsgCAPgrgzHeuIF
	lheZ3YPKTk/1MLexmgHF/X30t6xJLNMIW0WW1yUfA4WXiofPU59zrY+tAByuGBo82ARQX84NGjy
	Ysp2hv1R9AKGzdK+wdtM3YjeVK+P9dSvRZmWbJUe76gM9xBuBxRUIbSlwn+fO3Go4RRXEt0NP5q
	s+Sa9r0jbXi4fzjW83CCkX8eNFFrD/3ypkXt1goXKVCTKfakda6yUYptbqodELu/qjPxkLAMk7n
	7OPim5ar2/vNQNfI7t2TEYx+j
X-Google-Smtp-Source: AGHT+IEQbrz7RwyiGN8V+7z64D4xdgmsviG8r/Zzdp8SlBm6YsYUWWHHm2ur+UN7w5AuSq1h89JPbA==
X-Received: by 2002:a05:622a:2287:b0:494:a36c:ebd7 with SMTP id d75a77b69052e-4a713c35ff8mr32647061cf.34.1749606105997;
        Tue, 10 Jun 2025 18:41:45 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a619865d36sm80410911cf.56.2025.06.10.18.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 18:41:45 -0700 (PDT)
Date: Tue, 10 Jun 2025 21:41:44 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vt: add missing notification when switching back to text
 mode
Message-ID: <9o5ro928-0pp4-05rq-70p4-ro385n21n723@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Programs using poll() on /dev/vcsa to be notified when VT changes occur
were missing one case: the switch from gfx to text mode.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ed39d9cb4432..62049ceb34de 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4650,6 +4650,7 @@ void do_unblank_screen(int leaving_gfx)
 	set_palette(vc);
 	set_cursor(vc);
 	vt_event_post(VT_EVENT_UNBLANK, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 }
 EXPORT_SYMBOL(do_unblank_screen);
 
