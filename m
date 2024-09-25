Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13D176FA5
	for <linux-serial@vger.kernel.org>; Wed, 25 Sep 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276233; cv=none; b=NsEuxb3QZRULMQsCI23falEZkdxZavoY38wok8iRXuVvLVbGZ9KmUiRhSbOzkuhD8miFl9O06dacQPk74tg4Wq0ji2QmZKlGiPhv38xKa0/ymA0bGjNGR7eJqMP3Jpa7MV3tzg/f4yLyAzh8jTQzJN73iAUdnBGMh/p9ssIkHPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276233; c=relaxed/simple;
	bh=7UQgAge+viCesdMAgl8jIHoYVaYYmJ3Z3BjOM8Byfps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oED+VHj0yI/sNK/DQ6gDprwFZ0rj0H7xQCxM3lcoOm/A17Wa9DIr5elGnMCwg/5EQsxd7U1423ZxQALua/ti0OX32qKQ8DbzkjZ9kPkJa1SxUX5JsdNZA7TZGhVYc1FXKuPL62Ndh90Z8IC78V6tiKCVY2HgmGYUXtBFEeNuu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M8rFOxay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8rFOxay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C16AC4CEC3;
	Wed, 25 Sep 2024 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727276233;
	bh=7UQgAge+viCesdMAgl8jIHoYVaYYmJ3Z3BjOM8Byfps=;
	h=Date:From:To:Cc:Subject:From;
	b=M8rFOxayHr7sYY32/IZaaM3ndQIYupaAWMWRv7JYSwpwDXCOuM7reJLXfl+zDWb7+
	 DeEaOiH1JzNZI41U4rOBUUC3ArlXef22Bq1nRugHk6WOhNr3je02Y9/JLUxPh5WGUz
	 zpIzVqs0mu5orlyXz94VTCvGfgYc0uDmnpF4d0RM=
Date: Wed, 25 Sep 2024 10:57:12 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-serial@vger.kernel.org, helpdesk@kernel.org
Subject: Bouncing maintainer: Peter Korsgaard (XILINX UARTLITE SERIAL DRIVER)
Message-ID: <20240925-cute-viper-of-skill-a55aae@lemur>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Peter:

You are listed as the sole maintainer for the following subsystem:

    SUNDANCE NETWORK DRIVER
        M: Peter Korsgaard <jacmet@sunsite.dk>

This address is bouncing, so please send out a patch updating MAINTAINERS and
adding an entry to the .mailmap file with your preferred new destination.

Best regards,
--
Konstantin Ryabitsev
Linux Foundation

bugspray track
