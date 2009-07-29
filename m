From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: CTRL-C functionality.
Date: Tue, 28 Jul 2009 23:08:00 -0700
Message-ID: <4A6FE740.7020302@gmail.com>
References: <241b8f7b0907282250k56807b83vba95ee9944d14edb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:58753 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZG2GHx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Jul 2009 02:07:53 -0400
In-Reply-To: <241b8f7b0907282250k56807b83vba95ee9944d14edb@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Prabhu Chawandi <prabhu.chavandi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Prabhu Chawandi wrote:
> Hi All,
>
>    where  exactly can I check for the above signal is caught properly
> or not.  How to enable ?
>
> Because when I do ctrl-c my linux application is not terminating, I
> want that signal to be cought.
>
> It is the customized linux for the STB, soon box starts running
> ctrl-C should teminate application.
>
> have any Idea, where I need to look-in.
>
> Thanks
> Prabhu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>    
showkeys is the command for bash
xev is for xserver.

Justin P. Matock
