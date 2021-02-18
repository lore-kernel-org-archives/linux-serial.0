Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9498FC433DB
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 03:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC1264DE8
	for <linux-serial@archiver.kernel.org>; Thu, 18 Feb 2021 03:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBRD4u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:56:50 -0500
Received: from smtp46.i.mail.ru ([94.100.177.106]:39520 "EHLO smtp46.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhBRD4q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 17 Feb 2021 22:56:46 -0500
X-Greylist: delayed 71384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2021 22:56:45 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail3;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=CfE2kmv2Jh3jTuO7jAYn+cQfpyB3IyFx12hpViuiREQ=;
        b=F06D9TJiu7U6351Poznh5NJPKoSNhmXOYwAgZohB+D1RmBIj8vAfEF9c1amJU0z36xvX7HDp1k3O7t5JfDtxajJSrV2tfKSGXjcHksXXFUmT1lqRgUNL+pLWHbbn+bZXoVZyA0iLteiRwaZ9GkWBvK+3skl17Fey+uxufqxyjjM=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
        id 1lCaPy-0006Nk-VR; Thu, 18 Feb 2021 06:55:55 +0300
Date:   Thu, 18 Feb 2021 06:55:53 +0300
From:   Alexander Shiyan <shc_work@mail.ru>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] Revert "serial: max310x: rework RX interrupt handling"
Message-Id: <20210218065553.864bbf0cc2b3d398504c5b95@mail.ru>
In-Reply-To: <20210217235345.7326201b@windsurf.home>
References: <20210217080608.31192-1-shc_work@mail.ru>
        <20210217235345.7326201b@windsurf.home>
Organization: Mega-Milas
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp46.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru smtp.mailfrom=shc_work@mail.ru
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD975C3EC174F56692243410BA6471F01664CBE9F2A03BCE963182A05F53808504040124AB793CB79BFC9FF225D9E296C2002F9D5A667703E47B64A5EE24B7842E0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE757AEC41D7AA04458EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371A00CE7BDCE207EB8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FCC298FCDA1459180868CF172AAB62C784D1C2687FECDA7656389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0DCF4F0DC832992758941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6B0E9FD5D4288160ECC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C2249C290B73869BE36A276E601842F6C81A12EF20D2F80756B5F7E9C4E3C761E06A776E601842F6C81A127C277FBC8AE2E8BA575E19D76F34D563AA81AA40904B5D9DBF02ECDB25306B2B25CBF701D1BE8734AD6D5ED66289B5278DA827A17800CE76515C59FC18CEA6D67F23339F89546C5A8DF7F3B2552694A6FED454B719173D6725E5C173C3A84C3B62F86BFDE33731535872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5262717512240E674731EC182F4620AA9955CAE543B149141D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA753C350047980234DB410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D342B94C1DAF75C4D22A49490AFE8A9A66C8F3E4C6CDD27E0B6339497347BDB3786F2966B29249BAAE01D7E09C32AA3244C205361ED509CC87C4A5A07D5F82B61ADA95CA90A1D8AC565927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojspgX6BLqznOydTXeT2d/vQ==
X-Mailru-Sender: 3BC6B8CA5785035CFA3B5901239938C824B9C05803FB7B18BF7C2D375041E006581ABF9D1FAFDA346B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: Ok
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 17 Feb 2021 23:53:45 +0100
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

Hello.

> > This reverts commit fce3c5c1a2d9cd888f2987662ce17c0c651916b2.
> > 
> > FIFO is triggered 4 intervals after receiving a byte, it's good
> > when we don't care about the time of reception, but are only
> > interested in the presence of any activity on the line.
> > Unfortunately, this method is not suitable for all tasks,
> > for example, the RS-485 protocol will not work properly,
> > since the state machine must track the request-response time
> > and after the timeout expires, a decision is made that the device
> > on the line is not responding.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Thanks for the feedback. Should we switch between one mode and the
> other depending on whether RS232 or RS485 is used ? Or is there some
> appropriate user-space interface to ask the UART driver to tweak this
> kind of configuration ?

I wrote a little inaccurately, I did not mean a physical interface RS-485,
but rather a time-critical MODBUS protocol. (In our case it used on top on RS-485).

I do not know how best to solve this problem, it may be an additional parameter
for the devicetree, but in this case it is not clear how to manage it if the
devicetree is not used ...
This could be a Kconfig item (but something's not very good either).
Probably the best solution is to adapt some kind of IOCTL (or control via SYSFS).

In any case i feel free to test your modifications to the driver.

Thanks!
-- 
Alexander Shiyan <shc_work@mail.ru>
