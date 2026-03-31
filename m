Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E63D47D3
	for <linux-serial@vger.kernel.org>; Tue, 31 Mar 2026 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943705; cv=none; b=b49oVopnsG/xs46Ah7bluvxqYcJ+Hsrkd8x/90OCNP+AA67YCUDLWXiD4V2W27sdTmS34eTg6Z3SuUApWa5nLf13+FipEaEOdLfVaBASMJ+YXCy6LR+QKkgTKaDCLg8Erv7d4TqQh0oEjSXCO8XtseM/IWWjBS5UPicrlUf/cbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943705; c=relaxed/simple;
	bh=mX6Hzo62QiFFFPty2xoTZGQ5APUUAosC17dPxM+NjQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWjXPD+HMEktotUToR4QVuBw2qQLDzVmBbX4vQt2HMQZz7/NJcCxHMYc+UYfffn1wIlWLrXWjAgTu3zN4f4chYzUiZyVYEGsL6F1DcW52N3GoWdJrqWYOBoS7hXIDHztb5YJd2fTjRTtiSdOdjqXQU/i6jE5s1Gq+W2n5nSnw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jlP7pqye; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DO7mKONo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jlP7pqye";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DO7mKONo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V474vB4053882
	for <linux-serial@vger.kernel.org>; Tue, 31 Mar 2026 07:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IHK86B6bLbgi3XxVshcJV5jPOos83lecrnJ
	ISvWY/Tc=; b=jlP7pqyeGDhcbT/teoA7K77ZYRUTOrmRATqoC2yFJPPpdTLxMw3
	R6b0u5VJKyl3ovvhbUCnnIkceztRME7mX9hp+dzwoRiGWXuC9PL4zpIUCJIhnqza
	SVizA5ozap91We1NKMc9bTZLNDaXAAVLRyPj0E3n7cz5osjNA8SeeLTBffWmICHP
	0H8uzCbg9ywDYbCQetwSSSBxJrPJzGNhoS3mnPUfN1XB8w6NXkSBssijy3dqZENw
	FqUpF2lah2pBJqioNkFmPeRE4SdPSVtFBVI5Cr4Se+ppC7N38h037WC7VPk6fs+j
	3ViTfCcVWTvDVPW2379s4HlEIVzJF4odkPg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7xx3adwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 31 Mar 2026 07:55:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5094741c1c1so31221611cf.1
        for <linux-serial@vger.kernel.org>; Tue, 31 Mar 2026 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774943702; x=1775548502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHK86B6bLbgi3XxVshcJV5jPOos83lecrnJISvWY/Tc=;
        b=DO7mKONoxV+ffRJN9RKYN9Qlix6l4G0oUHWuuLrDULPwGumom4hpON7aA9uEZ8vYHR
         UhaDFJwpEYaf7NN2wZr/yZ1MNFb3RuDhN7KZnkf/HOHXr2TQHWLQ10aucveuxFJtUllp
         EE75wVQiTXBRbtShDFWFZEeWWfva4hc2JcLX4XmuFsUPGN9SI9N9exI8WTr/DQ0iEF0y
         2vZuJHm9h28nV4gMov7In4pp+CsuxkGWauyT41hRFy9icKdjeNc2rPuOMGMKzE0L+Uz8
         CD290E5ly979CpdBB2uUwhBjDqGa9p/RGyS6SlrwXmN6Bestfl0vLD8RUFijU/l6KCkW
         21/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943702; x=1775548502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHK86B6bLbgi3XxVshcJV5jPOos83lecrnJISvWY/Tc=;
        b=s+Bb4GlnMSkOTz4i2fGIuoUy3eQ7cYcjTT6E+TVWFAj79SuMjYyusp6QknR0Wb0hHQ
         n5q44XcBT/MSqAxnNUq3pGjXwbdoKALdZmsNrmu6qpiDBw8kU6zJXQreUtN/SV0neJeR
         uTehCOvfdiKD+A8tIkM4zrxLRW2ATmHlIyQIbwRR6cLd6/7MzpIy+cYE3eREn2QcSOgr
         woKp902pmCPm9S8USazzjV0ML7ThVZWl/p81TzLbQHOmOsnCqvExsA1PGSEDJT2hh/Eu
         J5v7nolME3qB3H0nm62dQQKeDNETCGd8qAwlUdHOJp6Hykjp27UB1JPXow082aHfLeLi
         DAmg==
X-Gm-Message-State: AOJu0YwaPfneFPqKMufpTnI7umkWKR9mFvX6SNUt2nLtQojJILmEyxiN
	K37El+t6pRZ+MJ/g12+fi0rRa51ENGyZ6z8mJXAez6caNqu4soh3gpd3V20gT4qbJZ+eL7rzjdC
	RPICKj7Eg0D9DRThZd8mf3lEY8gSJ/5h/5KONiBk9BKKwvOy4URdhtUano8htKyMiz3M=
X-Gm-Gg: ATEYQzxhE1zxBIrhOlWB4m3VXVjJ7PNNK1ozyQmJl+1a06pZ6WjKK5v8ockEd9vAvxm
	xIEx1lhJPNNddl/T29QFJh8/Q9WBb9WhHtu/YnyrxBua0Ww77PDbUqbhbnOTa2/VQPC9TfrnTSw
	cbaHy8qQJuSRqSArPr2Skst2IOCxeIwme75NyoYbXy/mQnNuMsfst+gR3xsbBNcTYxT0k6KvJtK
	CQQvU4O1dG4kANZwJJChBxXiv1mpRzU6/hCkj8QfrGHUE4CRQTE9ecRs/Dk9NwIpRdZCeKOvkeZ
	9oiFYRHdm4nbcobGb5PbuC2n8SsbZHFAUTT5oUXmaMWcArb/PK5fNxYQDL9U0nHpEi4hOUSV/ei
	s5DsvenPIu65VHsP3Yqe96h3VeIRJEQKRGA6gsJfUjfP5vjBWKA==
X-Received: by 2002:a05:622a:285:b0:50b:4b21:781f with SMTP id d75a77b69052e-50ba388ef57mr211705601cf.26.1774943702247;
        Tue, 31 Mar 2026 00:55:02 -0700 (PDT)
X-Received: by 2002:a05:622a:285:b0:50b:4b21:781f with SMTP id d75a77b69052e-50ba388ef57mr211705311cf.26.1774943701522;
        Tue, 31 Mar 2026 00:55:01 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:29fb:516:a90f:8dda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8a4fc2sm9989255e9.21.2026.03.31.00.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:55:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] Immutable branch between pwrseq and serdev trees for v7.1-rc1
Date: Tue, 31 Mar 2026 09:54:50 +0200
Message-ID: <20260331075450.4791-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ErbfbCcA c=1 sm=1 tr=0 ts=69cb7dd7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=LWPZaY4NSDFKJMcdi9MA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: YMkBDhydkTl6cn7fDbQl5ltifpckjjN8
X-Proofpoint-GUID: YMkBDhydkTl6cn7fDbQl5ltifpckjjN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3NCBTYWx0ZWRfX3Af+14sIjPZb
 S78EHmn2dtXcxtYw+dI5LccVIVcD+3zmPK6X0Frb08168C9HeOHWk+nT4QBzhtvUrcpYKxYQj47
 tphRTPb4u+VgZc557u5gxb+BHwEpgiUcBz1YdT+j7NSCAYwHFZU9YWB0dA8DDXGB53YOZUsObxp
 lZ6rhnmwENCeQ0zysXnBeouRvVoYnZukrQInjv5K5AQVLwSxVHf3mp9LIjQ67lXUJgHeS0DmHsB
 JO5rdGJc0vyxcmLybNrt4f6RABCrCmEEcJDsTN7kwfjyEKMnDAuP7gvl/vmKTjNuHKbVTseJFof
 F0OfCwipq+t05PI6FdP/qTjGeTs35cmfRXPS/I99tQ/7gsRN3OGTB/XbUMg0V0KsPbyvVyn634m
 cslG4hULQ6X24k41pgxyUyQSTrKTxa6XAdt0wulEILa2/+AmkQblOlIx052H6wU+7Y5bjf0ajhp
 LQ0g+mhePh+b0yLIKVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310074

Hi Rob!

Please pull the following serdev changes I queued as prerequisite to the
power sequencing updates for the M.2 driver.

Thanks
Bartosz

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/ib-pwrseq-serdev-for-v7.1

for you to fetch changes up to 1785c7bc1495e4e22377edffaf0ff8c3c697647d:

  dt-bindings: serial: Document the graph port (2026-03-31 09:48:43 +0200)

----------------------------------------------------------------
Immutable branch between the pwrseq and serdev trees for v7.1-rc1

Provide new serdev helper for looking up controllers by their OF node
to be used in the power sequencing driver for the PCIe M.2 connector.

----------------------------------------------------------------
Manivannan Sadhasivam (4):
      serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
      serdev: Add an API to find the serdev controller associated with the devicetree node
      serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
      dt-bindings: serial: Document the graph port

 .../devicetree/bindings/serial/serial.yaml         |  3 +++
 drivers/tty/serdev/core.c                          | 28 +++++++++++++++++++++-
 include/linux/serdev.h                             | 24 +++++++++----------
 3 files changed, 42 insertions(+), 13 deletions(-)
