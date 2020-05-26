Return-Path: <SRS0=Q4jN=7I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AC7C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 26 May 2020 07:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D7C2053B
	for <linux-serial@archiver.kernel.org>; Tue, 26 May 2020 07:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="Ufwc+aT+";
	dkim=pass (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="Ufwc+aT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgEZHFp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 May 2020 03:05:45 -0400
Received: from fallback13.mail.ru ([94.100.179.30]:45966 "EHLO
        fallback13.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730279AbgEZHFm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 May 2020 03:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=UquhFQei2oPUl2tktWiBZq2ejFRtjtGt17BB31V1bhM=;
        b=Ufwc+aT+qYLP7FndT03GlVJCM9w3y+8KQUmiTDt3BapAaXZe/sb9jdbdeI/psBjDbMSyFXMMTMVhB8IkW+jCOHinxRAlzmjXuRqEp2Ig/mtdjb48w1q546U7WZzWYEe6O5+Tfx0KJwaXSL7oBr0zUEE1P7qApMKgIfwvO0SivCc=;
Received: from [10.161.64.49] (port=35532 helo=smtp41.i.mail.ru)
        by fallback13.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1jdTed-0007sC-36; Tue, 26 May 2020 10:05:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=UquhFQei2oPUl2tktWiBZq2ejFRtjtGt17BB31V1bhM=;
        b=Ufwc+aT+qYLP7FndT03GlVJCM9w3y+8KQUmiTDt3BapAaXZe/sb9jdbdeI/psBjDbMSyFXMMTMVhB8IkW+jCOHinxRAlzmjXuRqEp2Ig/mtdjb48w1q546U7WZzWYEe6O5+Tfx0KJwaXSL7oBr0zUEE1P7qApMKgIfwvO0SivCc=;
Received: by smtp41.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1jdTeS-0007NU-0G; Tue, 26 May 2020 10:05:28 +0300
Subject: Re: [PATCH] serial: 8250: probe all 16550A variants by default
To:     Josh Triplett <josh@joshtriplett.org>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        lukas@wunner.de, heikki.krogerus@linux.intel.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, radu-andrei.bulie@nxp.com
References: <20200525130238.3614179-1-olteanv@gmail.com>
 <20200525172815.GA445190@localhost>
From:   Maxim Kochetkov <fido_max@inbox.ru>
Message-ID: <d989c5fe-451d-e6b4-a2f1-f6330809af99@inbox.ru>
Date:   Tue, 26 May 2020 10:05:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525172815.GA445190@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD98895A71D0BFB19F3BDE4F74A10656627E6162CA822EBDB7B182A05F538085040B124BD1796BC140AA62A8807546B207BB7F0F555E92C8592A208BCF97AD184C6
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9D6DADD6B53929DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637ECAF4C2CEE0D0B2F8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC7D1C85336C5169C52E968C64C2AD31B5CA0A6FE7F79B5ED5389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C3CA5A41EBD8A3A0199FA2833FD35BB23DF004C906525384303BDABC7E18AA350CD8FC6C240DEA76428AA50765F7900637A6BC3D7070A0091FD81D268191BDAD3DBD4B6F7A4D31EC0B7A15B7713DBEF166D81D268191BDAD3D78DA827A17800CE7EA3A15E3BE8EFD46EC76A7562686271E8729DE7A884B61D135872C767BF85DA227C277FBC8AE2E8BDAE3FA6833AEA0C275ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-C8649E89: ADA203CE9850748709789E1D1A31D427B6AFD8F1D537DE21086A57C4DD4608E589F231E681630F3B
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB+E2w0c6KOnfnwkDl6bJww==
X-Mailru-Sender: C88E38A2D15C6BD1F5DE00CD2899341287673D08F83A8B6F1E6ED524FBF0F84DC0A5620E814974F1EE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDC84F5774DBD551731A2EB78C48C0A69ECEFD076FEF5A533FF26D0CF364D582602
X-7FA49CB5: 0D63561A33F958A5F7CA9A4C31F1A2B2B4E8194CC5E97197C8FBEF6EAD8577B08941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249798EDED4600259DE76E601842F6C81A12EF20D2F80756B5FDA63EEEA5E5E9D6576E601842F6C81A127C277FBC8AE2E8B5713130D288095B63AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C309A7649CC036878F35872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB+E2w0c6KOnxoyOk3m0jgA==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C900516D1E9AB9D42D95146EE1E9C18B21883A2EB78C48C0A69EC2937E38BB09F6E6CC099ADC76E806A99D50E20E2BC48EF5A30D242760C51EA9CEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This change breaks all my devices: OMAP-L138 (davinci based), LS1021A, 
T1040, Marvell (kirkwood2 based). Only enabling VARIANTS on all my 
devices fix the issue.

25.05.2020 20:28, Josh Triplett wrote:
> On Mon, May 25, 2020 at 04:02:38PM +0300, Vladimir Oltean wrote:
>> On NXP T1040, the UART is typically detected as 16550A_FSL64. After said
>> patch, it gets detected as plain 16550A and the Linux console is
>> completely garbled and missing characters.
> Interesting that there's*new*  powerpc hardware that needs these
> variants. I based the patch on the fact that, on x86 at least, hardware
> using these variants hasn't been made for a long time.
