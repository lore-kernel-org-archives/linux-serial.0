Return-Path: <SRS0=E9Is=CB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_50,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_MR_MRS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619DEC433DF
	for <linux-serial@archiver.kernel.org>; Sun, 23 Aug 2020 19:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB4F204FD
	for <linux-serial@archiver.kernel.org>; Sun, 23 Aug 2020 19:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgHWTph convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 23 Aug 2020 15:45:37 -0400
Received: from smg.telkomsa.net ([105.187.200.242]:55601 "EHLO
        smg1.telkomsa.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725868AbgHWTph (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 23 Aug 2020 15:45:37 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Aug 2020 15:45:35 EDT
X-AuditID: 69bbcaf1-be3ff700000015bc-60-5f42c6145912
Received: from zmmtarelay4.telkomsa.net ( [10.146.45.47])
        by smg1.telkomsa.net (Telkom Internet Messaging Gateway) with SMTP id A9.AC.05564.416C24F5; Sun, 23 Aug 2020 21:40:04 +0200 (CAT)
Received: from [192.168.43.163] (8ta-229-1-99.telkomadsl.co.za [197.229.1.99])
        by zmmtarelay4.telkomsa.net (Postfix) with ESMTPS id 794707EC59
        for <linux-serial@vger.kernel.org>; Sun, 23 Aug 2020 21:40:03 +0200 (SAST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Hi
To:     linux-serial@vger.kernel.org
From:   "Mr David Bailey" <edlyn@telkomsa.net>
Date:   Mon, 24 Aug 2020 05:10:03 +0930
Reply-To: david.bailey0515@zohomail.eu
Message-Id: <20200823194003.794707EC59@zmmtarelay4.telkomsa.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNmxnKUBkzDijXaoip0Q8VXOMWVDSaGPWDaPzRxDrIQBtKITOD
        WhMNKkFTF0xxgQZKW7QxAhKqqGyCDW6kicYlGLBAxAICbqGudXsDKvzc3HfOvee8e3Npkruu
        0tAGkyyIJt6oVakptTVuflz0vXW6Ba1uzXJf2anwRLRx2BObhHaoE1IEo2GvIM5fvVutby2/
        rMpK3//OlR+Wg7ZZUAQN7BLodpYiC1LTHNuIwO1whY0+/Ah6L92glCqSjYcX586qlJxhJ8HD
        otd/8bngdg6SFkTjfDZ8ssgKHMVOgMK2zjAlj2ZnwFDum5ESFTsP7nbtU2CKnQX3Ht4KV3IO
        dw7Xe8NH1RPB7/lCnEGMbZyxbZyxbZyxbczYgagrSCuZMwRJ4tN4WdjHm+MWLIzfY5LjZcGY
        npkh8fEmQfYgvDFDfevHWyhUoPcilkbaSCZne6KOC+P34n4vmkoT2snMbcc6HTcxOTPFrOcl
        vU7MNgqSFwFNaqOZDs8aHcek8OYDgpj5j5pGU9oYhl4Vp+NY5QPpgpAliP/Y6TStBeZwCxad
        JAppwv5Ug1Eeowk6QhGPxOJPK3ENI2XxGZIhbZRvRZtp/+sSF0l3jsT8a3YcHd4yHAdG4nD/
        RRfJUaZMk6CJYYYUG1aR0Geb/rsot3I3gPYMoDaEp45ieu7gskh8Sv+NFjVihk2F2spmCqyD
        ITUMdfzkwNdUHw3Vv20aKH/yZCO8e9O8C5p6O+0IqtqsNxEUlFm7EFjLgt0Igs8tfQi+BVo+
        Ijj96+R3BO3O93kE+L6ecxLQHXRUE1Douf2KAE+oNECAN+/tDwKOH3HnktD8pauAhBe+UD0J
        oRLfAxLsRcXtJNQc6+nGuP18gITL/to+EmtW5VHQ88h/jIKix6/sFOSWH3VSA3iHBN5hX/Ja
        ZYcyPzaaJgdtbTpwIth0/8765ptuMdDv6g8u753J13yVnldtMTcYroobkvue6WpPfKjjenYE
        N2WUbqv4cTC2sODxyxsRD9qyE1KdLVOP1BUnqROOppawV6W0QwaqYuLK4Ib8KaYkX3DZ4jq1
        1bHzfE1s9axHVz5vWVq83tN+4VnWvIbBvIbj8tIVWkrS8wvnkKLE/wFKNq2qxwMAAA==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Attention:

Promptly email Mr David Bailey on to lay claims to your INHERITED FUNDS.

Mr David Bailey
