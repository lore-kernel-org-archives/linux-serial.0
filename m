Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54408155A39;
	Wed, 15 May 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787885; cv=none; b=eTYWsG6E1WG8Oi445Ppnh9+UdAIe8nX0ZEpp47QoXSu/bppdSxI6GsTPvq0k08Rv5oupghdykoguuFnb/XP4KKt7ebIQK5u0vUuBubepWAj8qDvtmh7ZQi+oJe4cjVGxDoDmOJP8Kb3PcHDyGlVhepLvJe6CrGOnhgOy0Mu7e84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787885; c=relaxed/simple;
	bh=K9pUrey9iwJ9zdDprqczC3SrT0bRnsU3+KJkA44QU18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXQf3Jga5gg948vjB8wZ0Q3wAjbqOJn4XWSbPh3IS3DlNxo7Hk7EQNT5NE9G4MKKlWi+3uFRxbuPFgYLdzErQIEY0LgWRYC3cyE0+ASjFM68sgtUmXnC66DMULRs0tDP58zhtV6x6CnN7FKskTul7UYoiHUTiJEmRylKg1JaxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=CriNXepc; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="CriNXepc"
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 44FFibqP1094148
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 11:44:38 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4Vfcwj2Fmzzgd52Y;
	Wed, 15 May 2024 11:44:37 -0400 (EDT)
Date: Wed, 15 May 2024 11:44:36 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: N_HDLC line discipline: Race condition
Message-ID: <20240515114436.6004d568@gato.skoll.ca>
In-Reply-To: <20240515094252.5f63fce9@gato.skoll.ca>
References: <20240424173114.035ddd7b@gato.skoll.ca>
	<20240425140127.6504ade1@gato.skoll.ca>
	<c937cd80-ecd5-4d41-ad72-668661898039@kernel.org>
	<20240515094252.5f63fce9@gato.skoll.ca>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skoll.ca; h=date
	:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=canit2;
	 bh=VoGBRyU0H/NBWTU8B5Fxtx7l8dnR2drdhyFashA+41A=; b=CriNXepcl1iv
	UA7HB9qNXmUJUtpcij0KGQ+otpW20SEoQRvnGET/W1JOLAm7SedLIma4cqMCRfE3
	6StapdfH5ZEiOcRfeJmRjW1RyzsYkpycaOI0ew1OkOlUZHKomPAd9E2RJqW+8ak0
	Crgsujq0FM696l04JtA2rnufhXDu0qRGVBP2p4EOucZtMLg8ApNIqRDOrDkKbwRF
	xLDRVx8GIND5/1hkYyENaiMQBgFkoi5kfDcqnL/R/H9Q9etq/jK58gZaCvug3WqE
	3YKyeID+naZktLnqgAfO1m7uWQlSElfZhBeTgsEChZpO1/sN03ZK+rRTB0MSfu9a
	hIoUwAJmJA==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.16 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20240515 / 01cnrIC3D

On Wed, 15 May 2024 09:42:52 -0400
Dianne Skoll <dianne@skoll.ca> wrote:

> I guess it's hardware-dependent because I can't reproduce it on kernel
> 6.6 on a Raspberry Pi.

Please ignore the above.  The Pi kernel ships without N_HDLC enabled,
so the test results were wrong.

Regards,

Dianne.
