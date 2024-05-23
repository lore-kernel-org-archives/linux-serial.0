Received: from dianne.skoll.ca (dianne.skoll.ca [144.217.161.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4771494A6;
	Thu, 23 May 2024 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.161.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468278; cv=none; b=bAqz/KJ1Rp/kH2fH9kk6ACEtKZFq9hpW1k2XZ0zMSVOPI3RpvWC4eJnCsKhSfvfsmZyYva1iqoDbLhrSN74+xkm9nFsaaQtFu6rEa6fqYVbDtWvpsfZwb4zz1IduKdHBxg/5J6GKVe/3PnfrmfcOXzW6StChza1cIvKHnSCdyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468278; c=relaxed/simple;
	bh=FJWa/uNCr7cJhmS3SUB0xxF/4J8jPMsmYlv7f5oQz3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2y4s0JhND/P1o5DEKX4Yw07D2pmU+x9gjFz/DyrJVRAseDP/FiQIiPrsg0MP0zisZ6FyfqetpMAdAFs1U/iMKl8nI97P84kaWmiluRju2Kll7F42EDMIhTlBzK413ocnf+Kn0MFJFXaoOSwCaWkE0xQ1isKNlEEL7EVMiqh70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca; spf=pass smtp.mailfrom=skoll.ca; dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b=DyO73YN/; arc=none smtp.client-ip=144.217.161.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skoll.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skoll.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skoll.ca header.i=@skoll.ca header.b="DyO73YN/"
Received: from pi4.skoll.ca ([192.168.84.18])
	by dianne.skoll.ca (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 44NCiF9M495868
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 08:44:16 -0400
Received: from gato.skoll.ca (gato.skoll.ca [192.168.83.21])
	by pi4.skoll.ca (Postfix) with ESMTPS id 4VlSXt54VRzgd52Y;
	Thu, 23 May 2024 08:44:14 -0400 (EDT)
Date: Thu, 23 May 2024 08:44:09 -0400
From: Dianne Skoll <dianne@skoll.ca>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: N_HDLC line discipline: Race condition
Message-ID: <20240523084409.150fccb1@gato.skoll.ca>
In-Reply-To: <93ace08e-deb3-46e1-b318-18aecc210a85@kernel.org>
References: <20240424173114.035ddd7b@gato.skoll.ca>
	<20240425140127.6504ade1@gato.skoll.ca>
	<63a5a3c5-8362-4b93-a50e-10c9cdcffdd2@kernel.org>
	<20240521101435.0b6b3420@gato.skoll.ca>
	<93ace08e-deb3-46e1-b318-18aecc210a85@kernel.org>
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
	 bh=5mf8k+q+wrhHknLna1GJnYemKxsMiU0vjw4WRkKWE8Y=; b=DyO73YN/mfLm
	TEkbOo+PW0u/6+wcMkcWw15ED10uLoqUjEacT+S053Oymz//TL6/J7vyJF9+H8b8
	nk9yr6akSKyRQYZE3ntDXfMbjFLyI5pWvdFU++fQa1jbBwDCYurMmFsbAZDOjSsQ
	Iu1D16A7w3KyirYrLOUtwx/UCE5B+HFwUlMd/vY4VzPL7Yu2S5sgnD66KXJeoa+I
	H0z/Qp9eBMhx69NsMhBLhwcEj2jUlTUYzHbgko6LhZz0C7Q1C+AlCWQEFSb7lfGf
	mgtnDhjrvxUDK2NlX24VMKZ2pEgz0zSSASumMFFWHdP9bHOJa1T6zJomqHUvUK7g
	z5Nxje7Okw==
X-Scanned-By: CanIt (www . roaringpenguin . com)
X-Scanned-By: mailmunge 3.16 on 192.168.83.18
X-Spam-Score: undef - relay 192.168.84.18 marked with skip_spam_scan
X-CanIt-Geo: No geolocation information available for 192.168.84.18
X-CanItPRO-Stream: outbound (inherits from default)
X-Canit-Stats-ID: Bayes signature not available
X-CanIt-Archive-Cluster: tWKWaF/NcZkqjWIj0BEJTBHJhwY
X-CanIt-Archived-As: base/20240523 / 01cqAIg3k

On Thu, 23 May 2024 10:01:51 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> The driver definitely behaves as described. If the ldisc is used on a
> real HW. ptys are a different story -- it's not guaranteed there.
> Does it make sense to use nhdlc on a pty pair? I believe not.

OK.  Well, the use case was as follows:  pppd has an option called `pty`
that makes it execute an arbitrary program, connect to its standard
input and output via a pty pair, and send and receive PPP frames over that
pty pair.

rp-pppoe (https://dianne.skoll.ca/projects/rp-pppoe/) includes a
program called `pppoe` designed to be on the other end of that pty
pair and receive/transmit the PPP frames via PPPoE.  pppd includes a
`sync` option, and pppoe a `-s` option that enable N_HDLC on the pty.
This lets pppoe just read/write a frame at a time without worrying
about PPP framing bytes or dealing with PPP escape characters, which
reduces the CPU overhead of pppoe.

Now, the Linux kernel has had built-in support for PPPoE for many
years, and I was thinking of dropping userspace PPPoE support, but I
heard from a user who wants to keep it.  ucLinux, it seems, does not
support dlopen(), so this user can't use pppd's `plugin` option to
load the kernel-mode PPPoE support module and has to keep using
user-space PPPoE.

Sync support was added to pppoe decades ago and either it worked well,
nobody used it, or nobody reported a bug until recently.  But anyway,
if the consensus is that N_HDLC shouldn't be used on a pty pair, I'm
fine with that.  Perhaps a comment in the source file and a note in
the N_HDLC documentation would be good, and then I'll just remove
support for `sync` and `-s` from pppoe, since it can't be guaranteed
to work correctly.

Regards,

Dianne.

