Received: from mx0a-00617f01.pphosted.com (mx0a-00617f01.pphosted.com [205.220.165.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECE3E0C57
	for <linux-serial@vger.kernel.org>; Wed,  7 Oct 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367856; cv=none; b=SLuV5f46V2454wyVO0i/isnyYVLiWqBuRgjaL8q3hqm5frwFMJjpBAv45Gr15qUXp8qR9kCYuDG4R21P92iSthZAgkGEcCt8vvRtrk4c7WLbhIDnPVKrT1TnS/0W5cvvhJcJNxgZ2ltIZQrx/qGTAX6AQcEeOdK51bWwgWZLoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367856; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bAQIyaFLr3TYdfQr60W3VtWKg/MUW+mJyqtjSMp+d40AWkW/fAeCPu5BXEYHTsWXTlWf44qHhSBKFLjhYQNpKMyJ7cd6H2w+MVm8P8ZTTdMnDV33lzFeLMLDw4Bx/d38qSRjq67ukhR7LiZnFmQdVgHTJo1HCeH8qI3baHRy7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com; spf=pass smtp.mailfrom=psmicorp.com; arc=none smtp.client-ip=205.220.165.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psmicorp.com
Received: from pps.filterd (m0247527.ppops.net [127.0.0.1])
	by mx0a-00617f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69700A1G3310158
	for <linux-serial@vger.kernel.org>; Tue, 6 Oct 2026 20:07:59 -0400
Received: from egc-exch2.psmicorp.com (webmail.psmicorp.com [38.142.134.66] (may be forged))
	by mx0a-00617f01.pphosted.com (PPS) with ESMTPS id 4h5b5e00p0-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 06 Oct 2026 20:07:58 -0400 (EDT)
Received: from EGC-EXCH2.psmicorp.com (10.1.1.111) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 6 Oct
 2026 17:55:51 -0400
Received: from psmicorp.com (10.1.1.107) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.2507.61 via Frontend
 Transport; Tue, 6 Oct 2026 17:55:50 -0400
Reply-To: <greg@gospelmusicuniversity.com>
From: Evans Thomas <_us@psmicorp.com>
To: <linux-serial@vger.kernel.org>
Subject: fund transfer opportunity,Reply..
Date: Tue, 6 Oct 2026 23:55:47 +0200
Message-ID: <20261006235547.E10846643367BCE3@psmicorp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: _pRul78VI5veD1-oJUQkLTRyk8sUJwn0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX65aB3eFcqJUX
 rTBIgR/HGZtMmn4iBmVkJgFNp1aX2zQq5q2+FY7qAj+5gjMCe5+ZLZnS2xSGQOa8rjLVheZfv26
 fnnMACnGxU8U1t0A11RuS6N9h23Zg4I7QoOAErowhuO239ikhiWa9XAPr90p3OmwC8QaN1OLAtz
 3ZshCgv/KJK8LwUQr/TWpIZPcJ0hWl5mg0A6EorKc+7wZWT8W6JUuibedD9SAj7Mh3Soiq7wz+t
 ZNgddVPhZuL6Z8LQlq8cefKqJmWeHrpnq1oNuHO4WYK3+obUWTtnzoRa5L+azoxeo5FKqpH3fL2
 RHuBxUnKxQ1ekJnw39HeXb0FS7PvzSYi/2eJqLSrmhsePte2+ScKY3WWInjqwrobgct64CMJ54b
 EEee2hs4oCCdjFoJmHUPPa66I8+H8YPaZfwBm/AA1O/z00o68Yao80jy+XMbmONbMPcfIeNlaPv
 Q06OY4vv4+Cv62pLuuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX3cEYq6E2m0Fs
 W1wgS9oi3Vwu3aVzNv+2Vif/kg8tVSf6N8vxtn7MsCMSxSkxAqfco2rrhMqHgy9tYOgchasIw/t
 tbxBkVrhYK2tFOSuOYohOFa77ON0f6it2JkWfZ1li03EQIIu6IXs
X-Authority-Analysis: v=2.4 cv=GvTXaU1C c=1 sm=1 tr=0 ts=6ac58d5e cx=c_pps
 a=sNj4pI0fii9qGHoVqNzRVg==:117 a=sNj4pI0fii9qGHoVqNzRVg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZHGAjPH774soz-f4Le74:22
 a=GfZueQGhKz3ujf-POmTq:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-ORIG-GUID: _pRul78VI5veD1-oJUQkLTRyk8sUJwn0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070000

