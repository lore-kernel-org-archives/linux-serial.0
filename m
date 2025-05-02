Received: from mail.ana.ir (mail.ana.ir [94.182.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10BD1E0DDC
	for <linux-serial@vger.kernel.org>; Fri,  2 May 2025 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.182.146.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177300; cv=none; b=X5wBHHMupuBJP2zVkQnp/SfqwFPBgjqBJYfH+VZqQUjhyvjotM/cT8blizKa5hXR5YpyNjMC0UeB09H8m3NZkg7TbevlP3xOvHSm/WlhD/SEmCCuNF0Wrifj5SNKrWdnl39tHH/8g/O3pe2SNY2LdH6XIwmFH73XAB3wWq6vQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177300; c=relaxed/simple;
	bh=3aE1fd0kQeuW8iPvZCpostA5mkJ1QKX4YBBon8sngyc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dItALB7323k2PBm7KDTUZhA0Sh5K5ZsYn4p3xiwenBD6RHR1EsjP329JmUMxvTNkT/zIfiL+SG7Xo0U1iOQjlX12lSbeOrg+o+JifsWzSHX0tge3P/NJk3AAg+8jD+89kYGTRzHJUi+Ez8c1k/HgLH2agMoBgJAprbT8GM/I24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etihadaviation.com; spf=fail smtp.mailfrom=etihadaviation.com; dkim=fail (0-bit key) header.d=etihadaviation.com header.i=@etihadaviation.com header.b=eQsQYj7W reason="key not found in DNS"; arc=none smtp.client-ip=94.182.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etihadaviation.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=etihadaviation.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=etihadaviation.com header.i=@etihadaviation.com header.b="eQsQYj7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etihadaviation.com;
	s=mail; t=1746174360; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NZbp325f1KFvcVpk08EPj44FtVfz65+5i20x5nXXdpk=;
	b=eQsQYj7W2pcjwKqhp8s6uFD2QG2YwIh0ROrQ1+yeeqYKw7X7P9nyByOGyJ929xPTbQaV1O
	bYBDyxqQfIQjy8j/TVdo+3boG7e6AE+CLRxqLYOrd4tnW+3Smw2rmBgJPom6iUEsC5RO2x
	XaP3xU0DRV/4z65SFp1HWFz3uf/DsNA=
Reply-To: vendorscontractor@serviceetihadaviationgroup.com
From: ETIHAD AVIATION GROUP<admin@etihadaviation.com>
To: linux-serial@vger.kernel.org
Subject: Vendor Registration 
Date: 02 May 2025 01:25:58 -0700
Message-ID: <20250501235730.BD26706404000B04@etihadaviation.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: mail.ana.ir;
	auth=pass smtp.auth=info@ana.ir smtp.mailfrom=admin@etihadaviation.com
X-Spam: Yes

Attn: Sir/Madam,

Greetings from Etihad Aviation Group, UAE.

We are happy to contact your company and also extend our=20
invitation to your esteemed company to Vendor/Contractor=20
Partnership registration with Etihad Aviation Group, UAE=20
2025/2026 projects. If you have intention to participate in the=20
process, please confirm your interest by asking for Vendor=20
Questionnaire and EOI.

We appreciate your interest in this invitation, and look forward=20
to your early response.

Best Regards,

Mr. Ben Stokes  ,
Contractors Coordinator
Group Procurement & Contracts Shared Services Center
Etihad Aviation Group PJSC
New Airport Road,
Khalifa City.
P O Box 35566.
Abu Dhabi, UAE
Email:  vendorscontractor@serviceetihadaviationgroup.com


