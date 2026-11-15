Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760599;
	b=gkiy1ern2yf7zE4LrqSjxSOGiSLC761wtlsI4U2s6u/ce3iU7b+6ibghZdwH63PZ/dWZ
	 diNLla7WE7j3xiWjhrirMaav7zk4iTKQytWohUVcUu2cUNjs907IKw8IzJX5ZrGTJXs2S
	 pkWLZr73etiAx/WI3v7E8CpP6IgY9P+lj5OHLJrO8paMqnKZ91E1EAMvF8gHZkH9UU+vI
	 tyV1EuP2aE78g3gLuPhwdlix8oN73dd374tp+MziuC6kgWJAeylEKfIs6wRX5Bogp2IKK
	 eFsTR1FQuKbijd+5EBOjXWvou0jCh897901oMqTWDlCqA18RPWgsgAqEaM+6vrv8w7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mcJ8+QiHfS18UpwkZcfAlWMTf5+8/6l6MYdHWQbUNrY=;
	b=eJd8AdJE4yApBXTCzzgJXurEuLyTe5251ZFBRXCIp7CaDV+iCTaXynVTq9jk4zscTtSr
	 NiOfezn3iqkn7lOOuPWhlM8hwi1r8Fco7uEYuu22Zgd8GthTeFyKZ7Ay+EKr1bcnc4Ekh
	 3QZrjZSRFIrJU5dE6SFWlb1AsYoep8VtQZrE4lXsqQW3KHe/JD2+yn/ailQJSRdzGOE68
	 3I5UtaOOX1sA64VwOZUdA9TzcLLeP2U4Nwj/D/UKmFOmYH9Vz36SIXHe9DYLx2UMrAYPj
	 AYda7Zx+ycETuyJeDWrrxqZ/FC2IbXQJ8JQz6O9t1/fbG4Yx5MLSsD3bqCyYoydG/Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2j17ZL+;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F402606A31F
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 16:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F402606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2j17ZL+
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so3864904c88.0
        for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794760598; x=1795365398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcJ8+QiHfS18UpwkZcfAlWMTf5+8/6l6MYdHWQbUNrY=;
        b=L2j17ZL+18b2OBG87DnI+1KDb7D7TAb3Aw4q8WzaoBOjXcBmQtsGNSthE2Y4pNzlk7
         ckFHiYnitlzKUpgLq4K7bNZ0ZDQiXp6MJRQI5psk67JK9B12ywAhFQzpaTTBZh88DhmS
         JjKxK47NZtgMZRdO8fMBIzEYEsL4v/zATLNacc38fUuScdRYnMnTZNSO5oA5CihXO2pN
         dN/TVsPB1SjUUrlbW3XdTp1bN2vnjKJfxc/T3u6/inS6K1o0ZUVQAiinYUsikCMYWz1n
         ofsAmqyoWK0H5NGyvDzQmkU1u6SI6NOXndJaiPLMv1wJCO1XytqQ/LylGHHitfmFkpPF
         gwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794760598; x=1795365398;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mcJ8+QiHfS18UpwkZcfAlWMTf5+8/6l6MYdHWQbUNrY=;
        b=yR43ndmdFytYGa9ubWzDlGbnZkDg7Q9KaPB1AR2KmxzcCLB0lUkR2Na1moftRvFntL
         10dTXc9HlVcbG6DFxNk+On54UpZhdIV1HqEGByhy1RpabBZVbDLUdXlt03WDWz1Q7a6z
         +ekkVWO1UfqZKls0VBX0pPw9nOQoh2OfQf13tOHLxzIaVNiiFSNkRJBbUY4iGokZN1C6
         i63Iul3E7UnYE58LsfKgQ5IxkRmbtmyOKSVjnkTlTLcwPLruK2puu1o2jCZPSH6vGNoF
         nH9/pgMW6mUizvpc27l7qUV4/RdQ5Wxe6spq7xsDep2GQkR0GZlfoD69nNMjNqHrV+fp
         vD/g==
X-Gm-Message-State: APuU4Z8XvFkjyFCGJgzU4ef3tb93JLXOe3W4H5QijzakSxvnEmSsvT7R
	DKu3wkkVuNrPsX4LkEnP6t5KiRgBbzlajmORnv81jSGzJUmfJMjOFBH+
X-Gm-Gg: AYBFou2jDqvlUZhXsFXmI+yaxeaoe7VgeHP/hfiL7lv6vncwrxYdmLbyZ9ZfVfQ1bAU
	J6oWVY1HnyyY1kYTB7fdadtcA2bxzE+WUo2Wq/a+u8Y716isy+PBz71PFzhxJH09V3+D57xoH7D
	ICYHkYJ9mnF+trZVUbscRBdvJOYPGvkaieAxdmo4dLN4XP2+hGIn0B116Mu9p3PF69ZyV5GMjww
	GBLiC8a2ZSsWPjFnbcE52JMXnCpXdwjkEE9UQ8Hop0oidl4x/xnE8ZdJ4XoDWl1OXyhh1F04bE/
	WHx4dHnA2jTwlL6yzrAzjLNWpkB4pbbG46hRTaJtT7HhPgO1kMt9AQwUn7EOmiRQmzNXKZm5vlD
	63/g8kr/Lxkm8ZHgj8zK/yvji6nFS8rgs0wOw01RnYGZE0tKm3Ve0IPxj9pbsiN3U91YiXt8A3+
	LUw66XFITvc+Uw2EFzv5QA41SQqafJoqN+UwtqzLg55ICxIgioLFKPjlgeq/UAOFlISoW6nvpvt
	ywUrEC2SqPJ2vCUrM1MR4VXvuoeracZLXoFj2cusBz6N6K0lKeNXzhaIXUhbMQ4bFUMt64inuXK
	LPahQr/uol58OvpRKByOo7lw+HgO6jb1Xk06EcAp6Po+Z+hM2SuyujuWP2orhb8zgoN7
X-Received: by 2002:a05:7022:108c:b0:143:2967:c0b1 with SMTP id a92af1059eb24-1b5030b6178mr6760986c88.25.1794760598420;
        Sun, 15 Nov 2026 08:36:38 -0800 (PST)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm33639439c88.9.2026.11.15.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 08:36:37 -0800 (PST)
From: Cheng Yongkang <teel4res@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] tty: TIOCSSOFTCAR ignores a locked CLOCAL
Date: Sun, 15 Nov 2026 08:36:28 -0800
Message-Id: <20261115163628.225925-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg, Jiri,

I hit a small inconsistency in tty_change_softcar(). It only matters
if an admin locks CLOCAL with TIOCSLCKTRMIOS, so it may not be worth
fixing. I am reporting it in case you want it.

Every other termios change in tty_ioctl.c goes through
tty_set_termios(), which applies the lock with unset_locked_termios().
tty_change_softcar() writes tty->termios directly and calls the
driver's ->set_termios(), so TIOCSSOFTCAR can change a locked CLOCAL.
It also skips the ldisc ->set_termios() call that tty_set_termios()
makes.

I only have a pty to test with, where CLOCAL itself means little. On
v7.3, root set and locked CLOCAL on a pty and then dropped to uid
65534, keeping the master fd. TIOCSSOFTCAR(0) returned 0 and cleared
CLOCAL, while TIOCGLCKTRMIOS still reported it locked. A following
TCSETS with CLOCAL=1 could not set it back, because the lock now kept
the changed value. The code is unchanged in next-20261113.

One way to fix it is to build the new termios in tty_change_softcar()
and pass it to tty_set_termios(). The lock and the ldisc call then
apply as for TCSETS, and the existing C_CLOCAL(tty) != bit check
returns -EINVAL when the bit is locked. I tested a smaller version
that returns -EPERM when CLOCAL is locked, not this one. I can send a
patch in whichever form you prefer.

Thanks,
Cheng Yongkang
