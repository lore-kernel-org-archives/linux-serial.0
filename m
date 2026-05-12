Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF383D7D76;
	Tue, 12 May 2026 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617438; cv=none; b=dmXtnQ53gsYVcWflXdv3kayM4A+0iDi9B5/bZgGaGvYqlwMNSzr+rgCwEbf5lBu+VdoF7oXzf64JZqxq8q7iKQYUIKKdeHmPkfVZeWIiApgh5/c5s7N/ISr0w9fzCRYLPyzHsqMdYr3vv3TeyVjRk0yhIRjuBCJetlxsswhYFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617438; c=relaxed/simple;
	bh=V5pxRavQXhQiieBOCZ+r7S051a3NAJpBgPWkNOf6QJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bz0VagghAHy2Kd/X7AnMJA6qZKAX5NFknsK86s01RY/ztKVt0J+d2T7MmmcdA7PGICktUC5k+Efhx5GOqanVA+AI+kP4hSBSvnbbC5XEG56l2O3M8/KaeUdjJC1a8WOVzm7LGVrOmDywg7lDSfCcV8vE9Rz7obiP5gh4pKbbfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwhI2IP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwhI2IP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6979C2BCF6;
	Tue, 12 May 2026 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778617437;
	bh=V5pxRavQXhQiieBOCZ+r7S051a3NAJpBgPWkNOf6QJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwhI2IP5Lrr/mpaRyEwlyEyUo2bhoo0nQ8vJX5sNvX7CIxthKb5qHqYavhLrUApwj
	 zLGGYQTYG+bfEdA4WffbfYia+lhOL3PaU8CKgpQP+4H+1JxNsf6iIgPkHLmyhsi3RY
	 2kngULM47qCAswQFq8keo+w7ia+6NLnjEBfdKDhEdUhr9IEm9y9Vl8LT6nPxLjzNBB
	 PSxIRaK7z5sXiGOB1M3XLBs+ujfM+Hs31Pw1YWZIPz+iqVt7PhENTuOFhMDYDujKh5
	 Y+2CHyYCYO+nciMdVXe3N8gekTEU/Z/UW6IKcuugQNZ1+fdxG19qh1E4G/Eu6j0JMR
	 HzBHGvRalNu7w==
From: Bjorn Andersson <andersson@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Praveen Talari <quic_ptalari@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: qcom: geni-se-qup: Add compatible for SA8797P SoC
Date: Tue, 12 May 2026 15:23:10 -0500
Message-ID: <177861739377.1242344.15173839569832124812.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427005901.230237-1-shengchao.guo@oss.qualcomm.com>
References: <20260427005901.230237-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Apr 2026 08:59:01 +0800, Shawn Guo wrote:
> Document GENI Serial Engine QUP Wrapper Controller on Nord SA8797P SoC
> which is compatible with SA8255P one.
> 
> 

Applied, thanks!

[1/1] dt-bindings: qcom: geni-se-qup: Add compatible for SA8797P SoC
      commit: 35466ef5db1fbdff49c4142026c4c56514d5ff47

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
