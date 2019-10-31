const { makeUUID } = require('../server/bin/uuid.js')

test('UUID 테스트', () => {
    const getuuid = makeUUID();
    expect(getuuid()).toBe(getuuid());
})