Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB61A254E
	for <linux-serial@vger.kernel.org>; Wed, 24 Sep 2025 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674622; cv=pass; b=RDx3826h5rp3cm+y3+qzpQOb39Upx3sZih68W5TgJjd4u5IF+kgWSl9viuGVmFl2ZoNB5Vs9GZMxd1+mTZv3SjS8gG+zSBr9SXJ+nx9SidTE1O/35wI0ALdNibhO8xJPavvuFtfuBEqqhkKR9ZyxvG2hAxETMP5v2X14/JODzEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674622; c=relaxed/simple;
	bh=8SmxW3lABSK7Zz/qq+alC1AQd3LKfeUgKRz58ulMYQg=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=ovFXvNGqbH/uoUamajH/J6e+8b32ToO0D0zFpIpBD49JXV3UbhFouoGDUFx39R/GTvRyUjtQfHuwo2at7dKH+60LsKbaGafz8+2VJKhn+JRsJilypLF4M3FZH8xnmjE1EDgnAssUOcQC2jg8JBWDwhwBTB7ni5GH+jvXXt7nuQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=OmWltUqw; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="OmWltUqw"
ARC-Seal: i=1; a=rsa-sha256; t=1758674620; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=cVDHz2S/F8tGokCFJjtEA+wo/V99Oe6cHUNFKp+t80agQrj3AGIyrSQpkdw/78H/yj4Ucm28jdlosgmIojPwagFS08+lkvR7Zi3f570lbCOhG78lx3rpXS+WwsHD8lCWGix+oP8V845Pc8Cr3zf0TbmOr3jEtlWseUbV7qz8iaw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674620; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=8SmxW3lABSK7Zz/qq+alC1AQd3LKfeUgKRz58ulMYQg=; 
	b=OqmDu6xbKjnI8gtXM7VEwmd3/Fib/kX3KodnTEpHIPn2dUSUhA1gMIG8hrZGmy6CIzLeYKm2K6lB/fknsA5D2zG1QOwWxRlTElnXq44SiU7stDrAYbxKRqtDaZNCZoKNmXwnY+q321GaIiqvM8xKH7q0Pm1CA0UibyA8nnRgcl4=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9ab338c0-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653201955.3757470755555;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=OmWltUqwC04lnhmTlhz8fZ9HgZxjx/MfvVMBkX+LsHuQduomGwrjux5g23MQ733Ew4aFGt3DPnF3efjRImBynik2SRrlkgQj6+25XjNxZl694q3ZytARR3Phcl/5pCn48ju8VUv+YPVEu62p4/kXO2E4s88H6K+SyrTEpu+up0o=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=8SmxW3lABSK7Zz/qq+alC1AQd3LKfeUgKRz58ulMYQg=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-serial@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9ab338c0-98d8-11f0-ace3-525400721611.19978ffc64c@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9ab338c0-98d8-11f0-ace3-525400721611.19978ffc64c
X-JID: 2d6f.1aedd99b146bc1ac.s1.9ab338c0-98d8-11f0-ace3-525400721611.19978ffc64c
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9ab338c0-98d8-11f0-ace3-525400721611.19978ffc64c
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9ab338c0-98d8-11f0-ace3-525400721611.19978ffc64c
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9ab338c0-98d8-11f0-ace3-525400721611.19978ffc64c@zeptomail.com>
X-ZohoMailClient: External

To: linux-serial@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
