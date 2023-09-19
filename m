Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F4CD548A
	for <linux-serial@archiver.kernel.org>; Tue, 19 Sep 2023 07:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjISHhg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjISHhe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Sep 2023 03:37:34 -0400
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:37:28 PDT
Received: from mail.leeswilly.pl (mail.leeswilly.pl [89.116.26.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18112C
        for <linux-serial@vger.kernel.org>; Tue, 19 Sep 2023 00:37:28 -0700 (PDT)
Received: by mail.leeswilly.pl (Postfix, from userid 1001)
        id 473A0761301; Tue, 19 Sep 2023 09:30:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leeswilly.pl; s=mail;
        t=1695108666; bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=;
        h=Date:From:To:Subject:From;
        b=jl9pq0xYX20Kr4NuI2j3YEpcAHSP1prN0jDJ0rUMStazMUvAALAxkI7SF9+rOs8r9
         QLrR793zo6zLA2g8MxGhaUF0BhsexuF09uS/NqWvhP7ZiYIO0yjqbSZKTcMnHYjMFN
         BlJ9X8yz4GJGaSooxikM8hvxak3ZoJouege1B3OYUZNX3qECATX1e2woaWoF0HVWei
         BeDGk7tirPY3O9xrzP523T5mkmBgbjTYFq/B+14qLHCrcerPYqemkPAORadYbv1zHz
         UNTdbBkt91oW/z35C1S3JiFf9YLx6JsAvIMNxakPkR/XXSAX3tVb4zo7VRZL38+gFU
         h5ilKCHIeaClQ==
Received: by mail.leeswilly.pl for <linux-serial@vger.kernel.org>; Tue, 19 Sep 2023 07:30:18 GMT
Message-ID: <20230919084500-0.1.3z.bcf4.0.5tjor70k4l@leeswilly.pl>
Date:   Tue, 19 Sep 2023 07:30:18 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leeswilly.pl>
To:     <linux-serial@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leeswilly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Jakub Lemczak
