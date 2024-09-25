Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91E184538
	for <linux-serial@vger.kernel.org>; Wed, 25 Sep 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277676; cv=none; b=n7pCbja93KAKzdkd0ejinLi/qJkpk+tQEMmIpFB7gx4M+mztJD1XhZWYcktdA5k8jGYf8BpG2KobwrjqTud2WOjaX6pzWa6tSMzx2VlPbzZ54AfqkxFZwLErfrVdXdOzoNWXdypB0G+jYoLh7CtzyJuT3GKoYtVWjqVDeW17RNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277676; c=relaxed/simple;
	bh=4BwzDSWbkrVwtp/RHRnqU2vBiYRbPFCoM8N9s1nQ8DE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pKNmXd8da66AxNV8mp/qk/scdHyQH7wJmK+C7E4GyCcbkOWhOFEyuT795WpdXCqA+YwykqzCAhFta213jx/DeE5lXUPl/LQ3hkalvIDUfTcfGoJujCHYxBr3wboL+hH0iJomUj+BLyZhjohDPOVuLtbXoBC949Nkd2h6zzTTYLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B5641BF20A;
	Wed, 25 Sep 2024 15:21:05 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1stTpB-008IHS-2B;
	Wed, 25 Sep 2024 17:21:05 +0200
From: Peter Korsgaard <peter@korsgaard.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org,  helpdesk@kernel.org
Subject: Re: Bouncing maintainer: Peter Korsgaard (XILINX UARTLITE SERIAL
 DRIVER)
References: <20240925-cute-viper-of-skill-a55aae@lemur>
Date: Wed, 25 Sep 2024 17:21:05 +0200
In-Reply-To: <20240925-cute-viper-of-skill-a55aae@lemur> (Konstantin
	Ryabitsev's message of "Wed, 25 Sep 2024 10:57:12 -0400")
Message-ID: <87setng3oe.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: peter@korsgaard.com

>>>>> "Konstantin" == Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

 > Peter:
 > You are listed as the sole maintainer for the following subsystem:

 >     SUNDANCE NETWORK DRIVER
 >         M: Peter Korsgaard <jacmet@sunsite.dk>

 > This address is bouncing, so please send out a patch updating MAINTAINERS and
 > adding an entry to the .mailmap file with your preferred new destination.

I think there is a bug in your script, presumably this is related to the
uartlite driver instead (where I should send an update of my email
address):

XILINX UARTLITE SERIAL DRIVER
M:      Peter Korsgaard <jacmet@sunsite.dk>
L:      linux-serial@vger.kernel.org
S:      Maintained
F:      drivers/tty/serial/uartlite.c

I am pretty sure I never touched the sundance driver.

-- 
Bye, Peter Korsgaard
