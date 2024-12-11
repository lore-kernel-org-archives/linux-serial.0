Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9902451E2;
	Wed, 11 Dec 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903377; cv=none; b=tGreSs2Hz1bEX/NDqbgoukl00IX2ewywPjBSv0/HYhVQAaCYC8zPecwv0ILKGM0uf304FV+mltjuWfSsJzQSoOSdv7qn5EByUxsyA4LdZTZVkBnKI3UqqQimk+P+rW3ySvp0CDxETtiQnydp2llxdTBsPh5N1PRHR6Sz1YVGjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903377; c=relaxed/simple;
	bh=3BYFrpfoBWkzncuRERfG8AjWULfy8Zn9sdiA6VgF+ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgMkExyp5c84gvDpAdwPetW8b7q0atMg4VcXt2zvNe4iNy4TWJUG0Wh23QSZCpf5lmfIRzlbPB1yT2Vrx9Y56F6z1PZBMKeuVgc4xvRGkyHsChggWiuq/E+ACy2a1I4rYbjAtgIVksTP4P3KJ+MNBYsO5kGbJ7SngecjCtKJiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfkuJq18; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfkuJq18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FCAC4CED2;
	Wed, 11 Dec 2024 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733903377;
	bh=3BYFrpfoBWkzncuRERfG8AjWULfy8Zn9sdiA6VgF+ao=;
	h=From:To:Cc:Subject:Date:From;
	b=sfkuJq18V6K7ErLbNz9jMOM518SN1f4DwDkKCdvAvPCOfDQvQ5kvMmaysh2VMRCm6
	 3IifvxCBb7JODygZbBhy+b/aiPWhlsdP6CiSu+pNIAqz37vn7CPqg7vfn5i2gnZ51E
	 LGNDjtoat8FWkpX4YE45t6GQNKT83xc0lQtQk8GVYL6DQnUD5BvDyb0g1m4ds+DU7q
	 XdhN9c7GA65UZBiEBoDz61lEVIMvc6Hz4HfONFAaarEXt+MWBzXFbszZ7DikwePuiO
	 WhryD0WdlCDpXW/63jBnULYEsXemlL7Xle7J170pCktXku3PLR+vznYfGPFEvqBqF5
	 J2PVrS8tJGr7A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/3] tty: serial_core: little cleanup
Date: Wed, 11 Dec 2024 08:49:30 +0100
Message-ID: <20241211074933.92973-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches in this series are NOT supposed to change the behaviour. They
are suppose to make the reader more happy when reading the code.

Jiri Slaby (SUSE) (3):
  tty: serial_core: use more guard(mutex)
  tty: serial: get rid of exit label from uart_set_info()
  tty: serial: extract uart_change_port() from uart_set_info()

 drivers/tty/serial/serial_core.c | 261 ++++++++++++++-----------------
 1 file changed, 114 insertions(+), 147 deletions(-)

-- 
2.47.1

