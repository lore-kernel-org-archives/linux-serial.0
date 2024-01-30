Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D479949
	for <linux-serial@vger.kernel.org>; Tue, 30 Jan 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641074; cv=none; b=UkFx4OYQg7CYN1EQJJqgJSLFhtY9bZRybjElIAmp4E1B5rtZ9OV8jv1g78brkk24lBR4BN37sc2jhxkaJ1tXbhE2HEOjhYg89p7SKhSA5ARr8fx56gPmVcF/iVG1Ha6ZdW5I+Q0UdWEIrOixdJ+xVLMxtGi1AxkGebQwp03iDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641074; c=relaxed/simple;
	bh=k6HRdPozVBTmbethj///4v44JcIV6nTJmQs4So93nWE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwOXkgSd3mmUvmu0peuV1hbo2TRfgUDQpB13hDwiiw9j+we4HC/itSu1AMCDCFJlsRI9h0j/5keriM/7sScJFLvnI6NkFHmr4IHNs77WUnIzz2eOlO2Kvx8k6k7HqAIah7Iqimx3fMJG7bPnIIdPd78suHoy2C+6dJhBiSy0SrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=booGVQ8d; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="booGVQ8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1706641070; x=1706900270;
	bh=k6HRdPozVBTmbethj///4v44JcIV6nTJmQs4So93nWE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=booGVQ8dCrkbnpd2VeDyQENHr7gfcpo6TbD8YW3C4laEp1ZYJCUzfBa4FJQSCbj7q
	 ugrfd/bHNyEIUuuGG/CpvykTHSOkkN/74yV57n/7VbFnij/Egeyh5ylO1Cye0eC5sA
	 DICX+ZkTUpbcOyWiaCy7AQTrhjs9gEl+rOR70+lq5gIiz7XsLMqgxFxrB5d4NFClQD
	 hDGGNynJoD4lkUZrO3IHVN/PZzVxHv1xEJ6y4cL0RkPuWnID8siiO2crVyJ2RkyG6u
	 67HB9FGf0v3CcS6EnreFHKNU8nnqLlicxDJJ+OFFWOINNoP+AfDqZ3XWgz9jGmHEyh
	 Hgh3hnGttauyg==
Date: Tue, 30 Jan 2024 18:57:47 +0000
To: Jiri Slaby <jirislaby@kernel.org>
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: mxs-auart broken in v6.2 and onwards
Message-ID: <djtgk274iojly23xjb6kgx7ucgv6a4d23ix4vvr2cfskrkeb2r@uykelfkgrcg7>
In-Reply-To: <040064c5-c285-4e02-b545-47c5085f0068@kernel.org>
References: <miwgbnvy3hjpnricubg76ytpn7xoceehwahupy25bubbduu23s@om2lptpa26xw> <040064c5-c285-4e02-b545-47c5085f0068@kernel.org>
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

On Tue, Jan 30, 2024 at 10:38 +0100, Jiri Slaby wrote:
> Hm, the tx stop handling is weird throughout mxs. What about the
> attached patch?

It seems to fix the issue, but I do not see any way to fix this just for
mxs-auart.c without also changing serial_core.h, and thus affecting a
bunch of other drivers. Would reverting the changes from 2d141e683e9a
("tty: serial: use uart_port_tx() helper") for just mxs-auart.c be okay?
If so, I can do that, test it again, and send a patch.

--
Emil

