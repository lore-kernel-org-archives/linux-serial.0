Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB91BC33
	for <linux-serial@vger.kernel.org>; Sat, 27 Jan 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706391340; cv=none; b=jc6uc6K0Yjuj/pCcWqKJMrXnCTVmo1MJc0p8Lv1hyWICi0WdobHPULEOFeuVJTAk735gm77VMl/5Q9LxjWopTB6STk5lwekAQwlB1MGs41DoQgVu7Pqck4yg4WQv1AhJYckeh9Jigi/Pm9byw3OWCkr5zHmEf4zBe20eufj/n9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706391340; c=relaxed/simple;
	bh=XjB14sOEcNCjSPSGzjsVDfkM3EVNBsHsxxs1Zo++7WQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eRMZVeSVWkPRZBC4xT7mgWCVCiRzSfowjX1a9SBEyls2VavGq3qJARMNVqNoxXyWK1I1Wpkv2QxZF3qEEu3zfZzeZZ74K2ndakBXzg+QNcUB4e1aZczfVD7W8kLuEwo4l0riuy8mv7F8O/wxSL2KhMlaY9+eRmvImUrIhJnGKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Pm1Cz2uc; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Pm1Cz2uc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1706391328; x=1706650528;
	bh=XjB14sOEcNCjSPSGzjsVDfkM3EVNBsHsxxs1Zo++7WQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Pm1Cz2uc1Irqqa4Cker3zmeykpfVQuifl8xy4t6U7zGR2y0xekfG+hoH88A6YFGp1
	 c2um+AowgVouh3DM5EsszQ3krku+Uv/2iwNfGK5kO6piUUHHAv2WUVDIfW00R3a/G7
	 QRWVjUO1ZCK2GvMo043xwp2oYnA09r70boCOOdrAXwOW+k0Trk2R1vG+c8CwxUNqny
	 9VFrgXLpJSDZ6BQ2+BiUAxyRS4xf3aM8y/2Id33Zs2lZJb51T+sPyNYBWIUn4FiLz3
	 xwiN8lOS5TCJc+4Tj+qVnpry5Q3N+o//wdp+F65tkaaaJ76mqrkpz5gp04G0OJxQmh
	 aJ0UiQMTwTvTA==
Date: Sat, 27 Jan 2024 21:35:15 +0000
To: linux-serial@vger.kernel.org, jirislaby@kernel.org
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: mxs-auart broken in v6.2 and onwards
Message-ID: <miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw>
Feedback-ID: 20949900:user:proton
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

After updating Linux on an i.MX28 board, serial communication over AUART
broke. When I TX from the board and measure on the TX pin, it seems like
the HW fifo is not emptied before the transmission is stopped. I
bisected the bad commit to be 2d141e683e9a ("tty: serial: use
uart_port_tx() helper"). Since it concerns multiple drivers, simply
reverting it is not feasible. One solution would be to effectively
revert the commit for just mxs-auart.c, but maybe you have a better
idea? Any pointers is appreciated.

Regards,
Emil

