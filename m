Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03C1E376C;
	Fri, 11 Jul 2025 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264279; cv=none; b=DPp5R5wkGvyS/353J9t521+S0fGpxtbi1CsipZqQ17KGIp7GAeHrSrXzyOvZ/i0rYGTlavdRte3eiamrd/P/8u0fUnvx4xW44n+Q04Jw6bLxby+2lM1atqpNXmGsAgwEwiT1bJZxK1CirpWoEnLAcwzV45K/rtqgoOzoqBvV/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264279; c=relaxed/simple;
	bh=shaXRcZ4DcxZHLhSV2yUXmJMlJ1ULb0FbX0L/096KY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D82ORXjp71/Ipvc6cX2H2ChvC6BsH7DlZ6wpiw396V+/+lBWMf/rv6SEVtfjZYZQN/Wd6ruRjWq9ymIUPaMm989M5xE4of9dPraqUbhyxmlj4ABkmiJEO5BZmLb8EeGbgB87Diqo0fpeWbyH5XuAx0t4nlzoP6gQFDAA7r/bWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=2s9X84Lr; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="2s9X84Lr"
Received: from pps.filterd (m0484887.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJF5L2006450;
	Fri, 11 Jul 2025 20:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=CFhghDaYDvRo+jgynRqkW2BopM
	gh7PNoHt5sCRKIBbA=; b=2s9X84LrXmhqUbQOidKbXxWRAPWmw5E6QNREKjcrx4
	tUoe1Yafow9S6OBvPsWCi0TCgHa+EEP2UFO3p39eFP2qw9AC1ZM9FOQDiNPwlh1R
	vF8QSo+4VF2RMohcoAUQa9cyVpSEAnU2CSN0lKn7DQZVMR3rQ++oIeVvlxyPmPtD
	+8gskXL857NtigYVc3nKO4fEgZFk0PzbX04JMPbV3qCdqLwjNsYpd362bW7QELoV
	soVSXFhHT6C+qTXS7WzRbl3NVea+P1yYzeGEb/uS6p2WnsyMhJMlBwNBFum6cR2H
	TH6JqN6HCrFwPUGVEDrcAg1MI8s4AjhfGFULNUdFVVwQ==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 47u1e53kdr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 20:04:35 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 11 Jul 2025 15:04:33 -0500
Received: from cvadrevu-p620.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 11 Jul 2025 15:04:33
 -0500
From: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Chaitanya
 Vadrevu" <chaitanya.vadrevu@emerson.com>
Subject: [PATCH v2 0/2] serial: 8250_ni: Fix build warning
Date: Fri, 11 Jul 2025 15:04:16 -0500
Message-ID: <20250711200418.1858682-1-chaitanya.vadrevu@emerson.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1MCBTYWx0ZWRfX7KcI7uUyK9FC VuW3o0C7YJFd5pUwyOKHCL///Zs19XyhrAXUxGdLGUnSmA0GBawQiDpkPpt8aT2gRgk68ISGH0H x9xMbYssLvRqbAIvV7TEUUAjnoZunt24vTjC2U9+2KelV932BKqLyd4xHUXoz6K3a8+cwQKa/bR
 uOw3r5hzero4PWwBPGkJod68DBcueSr06yq/aXL3O3qbT7T0BtDFUY/DaiwAaZjWeY4CTzoAHGV h54iXZ0XnJqRuvGVrqkLGb6DyIlYznc2eYR39wSb0wQFkU1nSYxhncDCgtZjtZ2yX/XllrHL+6V yE4YDWeJT86gUC3ts+PygMTr1rzQ7mU9xf9GXHUi0yhlSG4StrWvlIpZ02jPZK4axmU9SDzFd4x
 +89P5sgjCV3K1sCx1t8Z83A/AEC/Efd1SNyUn7fKOGEyfbzPbMArOp2J8L+4RwlHHXT7ZNfg
X-Authority-Analysis: v=2.4 cv=LvWSymdc c=1 sm=1 tr=0 ts=68716e53 cx=c_pps a=VUOoxcgKHUMpfFMIT0tLvw==:117 a=VUOoxcgKHUMpfFMIT0tLvw==:17 a=Wb1JkmetP80A:10 a=R5ANPgxTQ9UNnHBAW6kA:9
X-Proofpoint-GUID: XprFhlbzw0sBpDI35ep8qLXp5opqu0pw
X-Proofpoint-ORIG-GUID: XprFhlbzw0sBpDI35ep8qLXp5opqu0pw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=847 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110150

Hi,

Series fixes build warning reported by kernel test robot and reorders
variables.

Thank you,
Chaitanya

Changes in v2:
- Moved variable reordering into it's own patch.
- Added Reviewd-by tag.

Chaitanya Vadrevu (2):
  serial: 8250_ni: Fix build warning
  serial: 8250_ni: Reorder local variables

 drivers/tty/serial/8250/8250_ni.c | 56 +++++++++++++++++--------------
 1 file changed, 30 insertions(+), 26 deletions(-)

-- 
2.43.0

