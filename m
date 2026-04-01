Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04AA35BDB7
	for <linux-serial@vger.kernel.org>; Wed,  1 Apr 2026 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027271; cv=none; b=XxEl0hse8u9T4Z869SU3TxFd00MTmTWv/H4DsHRTxclfWlUnDqiKmj/RnmgplIZDuuvjnjnfPxIMldUFpzMTdub5cBSValogN8OlUCvxUBM4kaRnNtrwci9/V3zX/fPRj4nFxGdEMKZQN1GiRVLXOL97gQE52zebmd4MKwgc0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027271; c=relaxed/simple;
	bh=2vEu0FMYjbU3hCQR7oBHMixia2zkpzxyg0rkOUGp7fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBTQqXtdNcNtuMQctkmtO4h5Q2wxIGpKLCfuCKIkaBlUCZ9CFimhW+XBDn53v0Nz8IbUa+pIIVO4n1ypsw1LKQq5RfDW6peUTA5aHhVROnDzvRF1Aj+pVOE+9quVXY0yE2ZCNkrkbe9rzxlL4rB+WuseQ3wfdU3HsF7PfZdz4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NxQCeHfe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Emo7kXVK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NxQCeHfe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Emo7kXVK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6311h6sm1578366
	for <linux-serial@vger.kernel.org>; Wed, 1 Apr 2026 07:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzih
	XMiqpqQI=; b=NxQCeHfeNLOCx9istPa04KOfV0L7++Z5drnpxa+rK4BKxN/bo8L
	MdvhBKm7g7YIW9OrBZKF0BR9Ns5JhDmZthaJPrdZpRNrMqTlpNinCGfB7F8BXkt3
	OTeosUc1hjaef7vOFG015DdKMbsCoHNhgasgjX+Qcdsg9kKY5O+AizQMU+Encrvz
	/wJh+AJRkYipbyGjvzAIfwIP+/rnXspi7NPCCEC6qfifqB8hF5z1qTHVhWko6aZH
	Y18R+jUrlpN3CG79JXt0UVWR3XzdH0sPtoomVgRRQk+LDfgmDprOxamLkJe1Nipm
	vj7Nv76PULg8AEXv5lCkgQOsoECjts4iTvQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8k6ktt28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2026 07:07:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35641c14663so7617267a91.2
        for <linux-serial@vger.kernel.org>; Wed, 01 Apr 2026 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775027268; x=1775632068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzihXMiqpqQI=;
        b=Emo7kXVKHfGIvuTymLrps6hca5bKSk69ZSbyJji3VX34sayeIRytZ+p9rBWiC9NKbk
         oGXfOE950RjgBhSRuAIje9GwipCh31heEg/xtCOq0TKC5/IWmzNDy5jbfiZqhpjXo/ZQ
         Hzysh8o66NPEFYmYMDgz+1qQwhcgJm1n7yN1G826youEebOYb6PcF1qc/pizjXU4YkpR
         EoUR/oQYiAquZzU1OYTQDlmEzGiE7GvwSOoiqG0lUPpwsKjOjTAZImQqQZWWHTo1q9pd
         +JHN9a7VrboEM6TiQVuJuJZGDFJj9YkO65ptBCav8hZ3N71tb3H5aCUUaFA0iy44QXe8
         eDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027268; x=1775632068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22A+Sj5chUc1iyVqke9i/KwfXM4BVovOzihXMiqpqQI=;
        b=c9RQoGS4JksOK7SZQUDKf7mUM5Dz6QAfAbp++QnjSHnNuqLf7OhVXFR+Yg98ZfOlYD
         aMswEYgO+RFPA4YAfx8bmLydhPmiYu4/2xSYsDQB0/29Xzy3X4Z1VmG/HKe36/EO4VFG
         DYIGc6TRIOq5hO8eZoJUs36I2DDtICLf6vj+sOZ6kHeHuLOhWzffZq+vLiSJbe7prcqx
         aqkvuDJKHr4kp9WRF2l6GP5TtphMEpWvmprbXgKUtUGquY3j9QR+WkTSqIyBSK9zQBjY
         oQfYpLkEtqssgBmEEM9sc/SSBUmeWBZ+RVY3Bjm2jPl75B4d3BWTcuA7iLEvLd0cklHq
         OH1g==
X-Forwarded-Encrypted: i=1; AJvYcCXlbO1H96jHli7xSAh2BWzDqizaNhfwAbOt/2PNBjk9Eeysw3h11RK0aQO9Z0UlKZwfzTNjZTC1MJjZLjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcYKsMR2Gwqpr3n4BGJISrXFL0Udy8MENWSuZeyc0jCYWoxgrA
	cZtVheXYtNYSt7+FXPC/rDonwN7VeDYnZWzBAXBOGOu5FW3bhTKFtQ4E5ywafEJkRluS1yrR/vc
	O8OBI0j1Fp8vHucCHPi6PJGMclgXmR1NTpHYlXsKW2stMZ4QjKBx/C6hiWlRFRY0TUZw=
X-Gm-Gg: ATEYQzyqeWAjF3UbHx8h8Ts9ryI5ocSxPfKKLoxM0adYNw1uMB/eNelRBflWuySguG3
	4yDlVkpjWHyk4jl2UEbacGA6l2HTYOcncaCTLe8JhT7r2t6iZmdSjsn8zM82wbLJAUm9tJpav/a
	PgGGKiRWfF1Wv7GTALU9uokwuRQjK/lmFjH4xK5S0yvSMG7eEHTRW9nXDilYF3ZuYGrp9ydJEyg
	wtO97RqgHO1q2JQLE6/DNYdqgTRrVFCEhFCXXKKZ0C4gcM+slx7zlt/PzcscF03mjJomSvHEQFm
	L9JPrJ/wIq5nfzcIGDSxZjbnHkHUCSlRcqFUjp/UMvbsq1PxPcOlWHLrEmxeiA78WnVb6ia8/Iy
	K23h7WlY6OYDuqUkq3JJqED4FBdJz4ji5NV5N
X-Received: by 2002:a17:90b:33d2:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35dc6fae012mr2416061a91.14.1775027267910;
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
X-Received: by 2002:a17:90b:33d2:b0:35b:e4d8:bb10 with SMTP id 98e67ed59e1d1-35dc6fae012mr2416032a91.14.1775027267407;
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
Received: from work ([120.60.63.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6e2fc9sm3956464a91.15.2026.04.01.00.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:47 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/3] Pwrseq/serdev fixes
Date: Wed,  1 Apr 2026 12:37:32 +0530
Message-ID: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfJmkePB c=1 sm=1 tr=0 ts=69ccc444 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=zTATW481NYPnotdwU90osA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=fsC5vgmolQPFgTpzX2QA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MSBTYWx0ZWRfX7RbNSEjBuPvE
 zvsxDpeZS+fna/Eb9zbnOYEtX2/SfJwMtg9/NR/razAuEjlHPZQtNyHVyHZY8No+biTd2iXqnEg
 287hoB2cGVHnJzvucWqSSqfCi/FAO2ZtEvxPjeAv+CGQnCvXv8zBntWVy5zUN6PAM5QmhAFUmnG
 AKKvsr7EhJwxtPMHSTWmNyvdfGQDpOHEfPPNGqmAkh9Fn/+IBikp1rRSrHXZNcYIKgrMMkEVfp0
 +esB2dgfn/nVTNJdnvVaJ2EDYWt8SvKj3Lvn93zp5H6bJA21W7djOT3tdrU6PEG/647i4Ji77Wg
 FoDwzwwP94Nhn7hI4fAo3masTTSJhcbgjxp8cBYtN0degS5LacIOjGugeJYWE5n1pC5dnhj140+
 TVP3IDd64K3/CZxrVgAs/cVvZ0DarDcWauL8tnZi9gHVjkcMDFe3F8y773naIaTV/KLb7RL69OY
 bIEdCfJhKgGOtXKpm5g==
X-Proofpoint-GUID: S4zwONuFfMY8YhC0PDxHVHMK6JrXJt3W
X-Proofpoint-ORIG-GUID: S4zwONuFfMY8YhC0PDxHVHMK6JrXJt3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010061

Hi Bartosz,

This series fixes build issues reported by kernel test robot on the recently
merged M.2 Key E pwrseq series.

Patches 2 and 3 can be squashed with offending commits, while patch 1 should be
applied separately.

- Mani 

Manivannan Sadhasivam (3):
  serdev: Add missing stubs for serdev APIs when CONFIG_SERIAL_DEV_BUS
    is not selected
  serdev: Add CONFIG_SERIAL_DEV_BUS guard for
    of_find_serdev_controller_by_node() API
  power: sequencing: pcie-m2: Guard the helper functions making use of
    PCI bus notifier

 drivers/power/sequencing/pwrseq-pcie-m2.c |  9 +++++
 include/linux/serdev.h                    | 46 +++++++++++++++++------
 2 files changed, 43 insertions(+), 12 deletions(-)

-- 
2.51.0

