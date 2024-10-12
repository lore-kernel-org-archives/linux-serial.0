Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E5A2564
	for <linux-serial@vger.kernel.org>; Sat, 12 Oct 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770322; cv=none; b=JcIbKmQSegXzdCm4MR8L0ZPI5H0dqBgwyJ4n1G4CX60XvL5s++rNtTUJuVR0Q2IjT7JNAWnOt0RexDSX3D3BGIL4Ioa6Z0AIHaNqcufWVVtFaY3D9Lmr0m16OPlSf2vbCJ7xbBZJ/Cej3vVwjubTwzo0D8KqrtpGiDyAsWNAFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770322; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=nsXjHRwa49fxwhnw2IJaMLwbu2KG4j697WxzF54+GmrDwN7KkoyMXTx/4dh3xphGe65khqhA0RC8NjHPiA0XrSk047U3E9D3TTp0tNQcgqeZ2kST5dxfOKrTMlWYb95Dqjx1prTAZK/8UTGJ2KKyGP6kFzKjN+GEs0NXQlFEoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpwmbgEf; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpwmbgEf"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2807233a12.2
        for <linux-serial@vger.kernel.org>; Sat, 12 Oct 2024 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728770319; x=1729375119; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=OpwmbgEfHhAs6B8R9DT8hNv5AJ86GOcJctKV81PzbthDzn2KwkJAiFGWWtJpj8bYp1
         9jDjYbQQtgRoDCIhjslC/fUnwUwAkiKhzvcJzNJgTZiV/5mJN+/QytmjVRh97W9pDltY
         BANzblTi3wvgYdjVoFrfjD2yewawCnj2TZm/n75tYjy/pdkAYRODXOq05ZqlEjNOcF6M
         IEurODz6WSEIiEFFOr/iNJqVv0+tqvTLYGNeapgzmSiwKfcixh9h3gCMW7HO00ZZWOu8
         J3oAAWtZXSTCIs7jzyFxIXehNx7H3SBGsR1jVOLrmVspeP/4nrGjBwMpp8tWqhgeM3BE
         /1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728770319; x=1729375119;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=o7wIQejJ/d2FdYrkJ7KFk/5hBN+p5y+3OP12K87iMbeo4J5L/4c/Q06jfaWFr7WvMd
         kt06HJsSx/9SvWwTjccxbXKrLtFJWchJpRJPnm4eWa7vhMN3W7vCBqFgdTf/tFRFpiQ5
         4dUxyOxUTgmlAzmv8+ENrVuu+xLDzp65huPNPutkytHOG6atepMJlNh9pawGRA0Vu/jj
         W6rsr+Dn3Q+X8zmJOSHlpcrOrSx/dUDH/O/t1MVKdD++6K6QP9NtQMKEGXejUl87y9c2
         ouMnhSUmEU5AAeKYqJBFtzmenYvuxSVgvSZWwe5WEdgazTyRJUHy5E6qD8DS7mEKZdzw
         srfQ==
X-Gm-Message-State: AOJu0YyMGuZCrTcpsDfO0rcTCcVxzJaVI7uya4f/fSgfpqRXlYJXmsbp
	z6i7GPD8/01g957QMss7LDklrDmonfzTfGs5xaexD7zFrYST2wNWQd+/9hB+
X-Google-Smtp-Source: AGHT+IFy+pyZ8sT3V14ikgLdS3Y52eLd+oNbHo4PaKMtsVAFLiQdCTRbLH9ibOq6RF7vgE2HQWUUWg==
X-Received: by 2002:a05:6a20:7f83:b0:1d8:d600:2c6b with SMTP id adf61e73a8af0-1d8d6002c7bmr964257637.3.1728770319532;
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea677587bfsm2199933a12.76.2024.10.12.14.58.38
        for <linux-serial@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
From: Josey Swihart <pedro.brito19925@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <d5d6de0cf4a29308349b434bb837687a4881b978cc86e633dbfd25f9ce8d0de1@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-serial@vger.kernel.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 17:58:37 -0400
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey
