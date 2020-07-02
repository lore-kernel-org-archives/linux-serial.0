Return-Path: <SRS0=ZZst=AN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4E4C433DF
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 07:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008B420899
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 07:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mnoPY0b4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7R5Opzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGBH1y (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:27:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43967 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbgGBH1y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Jul 2020 03:27:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F6315C019B;
        Thu,  2 Jul 2020 03:27:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 02 Jul 2020 03:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rIJmzRPYvkYMKxdKvzvcnJbs86j
        /KIyuC0qArRXIRQM=; b=mnoPY0b4qppt30R4eNCxEo3YxPZewHgMEAdeTmcTLIX
        XV8w57RuWDZs+dQqxaFlvEYzJl8VhxXbTjvd1BAEbXwKkkMVAyJ1gvYtkJvXIuys
        1wet+MaMQYNpDlkkVQwr6Wz22wQM1UhtQQefiOn8fxiIdQbw5Gd4Gk3xfn5gqOfv
        2s7DPZ1LU7V3xtDiY5BpqA72OB85m2/yjtq55umjDhgYfJ6awdoYb/Ty/Gb5W/S5
        fzBf0RDpmRvuqLLY7M5dpWcXQSuXdnb5bAOEl2eAkz9evigNKpkrJVBdj1Cu40PP
        1w1RQuiBjo34/gIAZfN3wpR9B0oSWN1dP+1n2R6WBkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rIJmzR
        PYvkYMKxdKvzvcnJbs86j/KIyuC0qArRXIRQM=; b=h7R5OpziwIza1SPO2yahWw
        JQVifnlxIRzfap0z/AFe1AhM7GgEmekg8m94cG2WogUc4xAvasxOxGdA7dpLWAgD
        cvtYtfhpzi8Lr4G7EYPL0OFLVasJ9q3XN+XEtxppJ5A32qidqBvk95MHPnEmy4bY
        PI5IykrZGtakqaR1uCyJXMfiWhaW9DR5ZY5ogfwwFGypu70xSIYtwKTgK/QHzUUh
        EsRs2dZbpJIQ4M0Z1gQje1HgxUQK2nZMyPrEEbRta6FriKL/Gc7Ww7E8/fuZRzEk
        4mwmQmY1sK3eehzgljIk3Bb+vlw5ZEAsWIsk45ZFmC5N5eaysDyQSN0trHVET7EQ
        ==
X-ME-Sender: <xms:eYz9Xvn3zJQTQYaFhvLCSBN1mrpOgBqpTI1v0BTcupYs4hjbfW-I0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdefgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:eYz9Xi1nkVG0QQtHEJo_MlPRe-AKXrz8Tmw9FYhj2GvuO3U_lQLJbQ>
    <xmx:eYz9Xlq0d3gyR9Oa5gU1XdDx9b9wqZHp2CEOyAwzRR40J6USwjnujA>
    <xmx:eYz9XnkS3GprFkExR9IJOtLCVdwfGn8bZmD-cjj3Y3MeoJ5XWIRjJA>
    <xmx:eYz9XuAIvYa3U-lWvXvDCQdrxvQZSiqfLNnlNiTKE0uhISH9gcAD3A>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id CDD9B306006D;
        Thu,  2 Jul 2020 03:27:52 -0400 (EDT)
Date:   Thu, 2 Jul 2020 09:27:57 +0200
From:   Greg KH <greg@kroah.com>
To:     Egmont Koblinger <egmont@gmail.com>
Cc:     linux-serial@vger.kernel.org
Subject: Re: PROBLEM: tty devices with future timestamps
Message-ID: <20200702072757.GA1052499@kroah.com>
References: <CAGWcZkJ5LMK59UWPP6zsV3ipgVNbk+mH7tVcmRGsp1PJzxBdTA@mail.gmail.com>
 <CAGWcZk+qZaNN1LOWxWjsBiP+JfSKDvD5+atNHe3LeWgWQhC=gw@mail.gmail.com>
 <20200701132309.GA2362785@kroah.com>
 <CAGWcZkKChAQwLx16yQ0b6aVx22UrmP_LaK2UjfXBnnZZvLHerQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWcZkKChAQwLx16yQ0b6aVx22UrmP_LaK2UjfXBnnZZvLHerQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 02, 2020 at 09:16:28AM +0200, Egmont Koblinger wrote:
> Hi Greg,
> 
> > What is this "problem" causing today?
> 
> This is probably only a cosmetic issue, rather than a
> strictly-speaking bug.  I mean, the tty line works fine, and the 8
> second resolution is a nice prevention against security/privacy
> issues.  I'm not aware of any misbehavior in any application (which,
> of course, does not guarantee that there isn't any).

Given that this change has been in linux for over 7 years (was
introduced in 2013), I'm sure we would have been told of any misbehavior
by now :)

> That being said, the device regularly having a future timestamp (and
> in turn, "ls -l" using a different formatting) is totally unexpected,
> and made me (and perhaps will make others) think that there must be
> something wrong with the system.
> 
> Is this a bug in coreutils's "ls"?  (That was my first suspect.)  ...
> Or am I experiencing clock skews?  Due to a hardware flaw?  Due to an
> ntp problem?   Is there a chance it'll affect some apps too?  ...  Or
> what else could it be?  ...  -- I was wondering.
> 
> If the code cares enough to update the timestamp at all -- which I
> would be fine without, I personally wouldn't mind if it stayed at the
> creation time of that tty line, or was always the Epoch --, and cares
> enough to reduce the precision -- which I find a good thing --, then I
> guess it should also take care of not setting it to a future
> timestamp, in order not to cause unexpected end-user results in "ls
> -l" and who knows what other tools.

We are doing a simple "knock the lower bits off and check" calculation
to make this fast, as it needs to be fast.  As for setting it in the
future, I don't think that's what is happening here, you are just
comparing two things that can't be compared as they are not the same
thing.

thanks,

greg k-h
